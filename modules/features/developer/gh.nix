{
  flake.homeModules.gh =
    { pkgs, ... }:
    let
      repoSetup = pkgs.writeShellApplication {
        name = "gh-repo-setup";
        runtimeInputs = [
          pkgs.gh
          pkgs.jq
        ];
        text = ''
          # Usage: gh setup [--checks "A,B"] [REPO]  (defaults to the repo in cwd)
          # --checks: CI check names a PR needs green before it can merge
          # Safe to re-run: the ruleset is replaced by what the flags describe.
          checks=""
          while [ $# -gt 0 ]; do
            case "$1" in
              --checks)
                checks="''${2:?--checks needs a comma-separated list}"
                shift 2
                ;;
              *) break ;;
            esac
          done
          repo="$(gh repo view ''${1:+"$1"} --json nameWithOwner -q .nameWithOwner)"

          gh repo edit "$repo" \
            --enable-squash-merge \
            --squash-merge-commit-message pr-title-description \
            --enable-merge-commit=false \
            --enable-rebase-merge=false \
            --delete-branch-on-merge \
            --enable-auto-merge \
            --allow-update-branch \
            --enable-wiki=false \
            --enable-projects=false \
            --enable-discussions=false

          gh repo edit "$repo" \
            --enable-secret-scanning \
            --enable-secret-scanning-push-protection \
            || echo "secret scanning not available for $repo, skipped"

          gh api --method PUT "repos/$repo/vulnerability-alerts"
          gh api --method PUT "repos/$repo/automated-security-fixes"

          # shellcheck disable=SC2016
          ruleset="$(jq -n --arg checks "$checks" '
            [
              { type: "deletion" },
              { type: "non_fast_forward" },
              { type: "required_linear_history" },
              { type: "pull_request", parameters: {
                  required_approving_review_count: 0,
                  dismiss_stale_reviews_on_push: false,
                  require_code_owner_review: false,
                  require_last_push_approval: false,
                  required_review_thread_resolution: true,
                  allowed_merge_methods: ["squash"]
              } }
            ]
            + (if $checks == "" then [] else [
              { type: "required_status_checks", parameters: {
                  strict_required_status_checks_policy: false,
                  required_status_checks:
                    ($checks | split(",") | map({ context: (sub("^ +"; "") | sub(" +$"; "")) }))
              } }
            ] end)
            | {
                name: "protect-default-branch",
                target: "branch",
                enforcement: "active",
                conditions: { ref_name: { include: ["~DEFAULT_BRANCH"], exclude: [] } },
                rules: .
              }
          ')"

          id="$(gh api "repos/$repo/rulesets?includes_parents=false" \
            --jq '.[] | select(.name == "protect-default-branch") | .id')"
          if [ -n "$id" ]; then
            gh api --method PUT "repos/$repo/rulesets/$id" --input - <<<"$ruleset"
          else
            gh api --method POST "repos/$repo/rulesets" --input - <<<"$ruleset"
          fi
        '';
      };
    in
    {
      home.packages = [ repoSetup ];

      programs.gh = {
        enable = true;
        settings = {
          git_protocol = "ssh";
          prompt = "enabled";
          editor = "vi";
          aliases = {
            # PRs
            pv = "pr view";
            pl = "pr list";
            pd = "pr diff";
            pc = "pr create --fill";
            pk = "pr checks";
            pm = "pr merge --squash --auto";

            # Actions — you have 4 workflows, this is where the typing is
            rl = "run list -L 10";
            rw = "run watch";
            rf = "run view --log-failed";
            rr = "run rerun --failed";

            # Issues
            il = "issue list";
            iv = "issue view";

            # runs for the branch you're actually on
            ci = "!gh run list --branch $(git branch --show-current) -L 5";

            # Repo
            # Example: gh init this-is-the-repo-name --public -d "This is a desc."
            init = ''
              !set -e
              git init -b main
              git add -A
              git commit -m "chore: initial commit"
              gh repo create "$@" --source=. --push
              gh setup'';

            # Example: gh new this-is-the-repo-name --template wallago/tpl --private
            new = ''
              !set -e
              gh repo create "$@" --clone
              gh setup "$1"'';

            # Apply preset settings + default-branch ruleset
            # Example: gh setup  |  gh setup --checks "Flake check,Statix" wallago/foo
            setup = "!gh-repo-setup \"$@\"";
          };
        };
      };
    };
}
