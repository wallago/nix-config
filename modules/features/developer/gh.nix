{
  flake.homeModules.gh =
    { pkgs, ... }:
    let
      repoSetup = pkgs.writeShellApplication {
        name = "gh-repo-setup";
        runtimeInputs = [ pkgs.gh ];
        text = ''
          # Usage: gh setup [REPO]  (defaults to the repo in cwd)
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

          gh api --method POST "repos/$repo/rulesets" --input - <<'EOF'
          {
            "name": "protect-default-branch",
            "target": "branch",
            "enforcement": "active",
            "conditions": { "ref_name": { "include": ["~DEFAULT_BRANCH"], "exclude": [] } },
            "rules": [
              { "type": "deletion" },
              { "type": "non_fast_forward" },
              { "type": "required_linear_history" }
            ]
          }
          EOF
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
            # Example: gh setup  |  gh setup wallago/foo
            setup = "!gh-repo-setup \"$@\"";
          };
        };
      };
    };
}
