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
              "git"
              "push"
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
