{
  flake.homeModules.jujutsu =
    { pkgs, config, ... }:
    {
      home.packages = with pkgs; [
        difftastic
        mergiraf
      ];

      programs.jujutsu = {
        enable = true;
        settings = {
          user = {
            name = config.programs.git.settings.user.name;
            email = config.programs.git.settings.user.email;
          };
          ui = {
            diff-formatter = "difft";
            diff-editor = ":builtin";
            merge-editor = "vimdiff";
            templates.git_push_bookmark = ''"wallago/" ++ change_id.short()'';
            conflict-marker-style = "git";
            default-command = "log";
            show-cryptographic-signatures = true;
          };
          merge-tools.vimdiff.program = "nvim";
          revsets = {
            log = "default() & recent()";
            bookmark-advance-to = "closest_pushable(@)";
          };
          revset-aliases = {
            "default()" = "coalesce(trunk(), root())::present(@) | ancestors(visible_heads() & recent(), 5)";
            "recent()" = ''committer_date(after:"1 month ago")'';
            "closest_pushable(to)" = ''
              heads(::to & mutable() & ~description(exact:"") & (~empty() | merges()))
            '';
          };
          aliases = {
            l = [ "log" ];
            s = [ "status" ];
            d = [ "diff" ];
            dg = [
              "diff"
              "--git"
            ];
            rs = [
              "resolve"
              "--tool"
              "mergiraf"
            ];
            f = [
              "git"
              "fetch"
            ];
            n = [ "new" ];
            sq = [ "squash" ];
            pp = [
              "util"
              "exec"
              "--"
              "sh"
              "-c"
              ''
                set -e
                jj git push "$@"
                if [ -n "$(jj log --no-graph -r '@ & bookmarks() & ~bookmarks(exact:"main")' -T commit_id)" ]; then
                  jj new
                fi
              ''
              "jj-pp"
            ];
            tug = [
              "bookmark"
              "advance"
            ];
            mine = [
              "log"
              "-r"
              "trunk().."
            ];
            sync = [
              "rebase"
              "-d"
              "trunk()"
            ];
            # Push REV (default: @, or @- if @ is empty) under an auto-named
            # bookmark and open a PR for it; re-running only pushes.
            # Usage: jj pr [REV] [gh pr create args...]
            pr = [
              "util"
              "exec"
              "--"
              "bash"
              "-euo"
              "pipefail"
              "-c"
              ''
                rev="''${1:-@}"; shift || true
                if [ "$rev" = "@" ] && [ "$(jj log -r @ --no-graph -T 'empty')" = "true" ]; then
                  rev="@-"
                fi
                jj git push --change "$rev"
                bookmark="$(jj log -r "$rev" --no-graph -T 'local_bookmarks.map(|b| b.name()).join("\n")' | head -n1)"
                if gh pr view "$bookmark" >/dev/null 2>&1; then
                  gh pr view "$bookmark" --json url -q .url
                else
                  gh pr create --head "$bookmark" --fill "$@"
                fi
                jj n
              ''
              ""
            ];
          };
          template-aliases = {
            "format_short_cryptographic_signature(sig)" = ''
              if(sig,
                sig.status(),
                "(no sig)",
              )
            '';
          };
        };
      };
    };
}
