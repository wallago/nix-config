{ config, ... }:
{
  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        name = config.programs.git.settings.user.name;
        email = config.programs.git.settings.user.email;
      };
      ui = {
        pager = "less -FRX";
        style = "square";
        diff-editor = [
          "nvim"
          "-c"
          "DiffEditor \$left \$right \$output"
        ];
        merge-editor = [
          "nvim"
          "-d"
          "$left"
          "$right"
          "-M"
          "$output"
        ];
        merge-tools.diffconflicts = {
          program = "nvim";
          merge-args = [
            "-c"
            "let g:jj_diffconflicts_marker_length=$marker_length"
            "-c"
            "JJDiffConflicts!"
            "$output"
            "$base"
            "$left"
            "$right"
          ];
          merge-tool-edits-conflict-markers = true;
        };
        default-command = "log-recent";
      };
      aliases = {
        l = [ "log" ];
        log-recent = [
          "log"
          "-r"
          "default() & recent()"
        ];
        tug = [
          "bookmark"
          "move"
          "--from"
          "heads(::@ & bookmarks())"
          "--to"
          "closest_pushable(@)"
        ];
        s = [ "status" ];
        d = [ "diff" ];
        n = [ "new" ];
        sq = [ "squash" ];
        mine = [
          "log"
          "-r"
          "trunk().."
        ];
        amend = [
          "squash"
          "--into"
          "@-"
        ];
        pp = [
          "git"
          "push"
        ];
        sync = [
          "rebase"
          "-d"
          "trunk()"
        ];
      };
      # signing = {
      #   backend = "gpg";
      #   behaviour =
      #     if config.programs.git.signing.signByDefault then "own" else "never";
      #   key = config.programs.git.signing.key;
      # };
      revset-aliases = {
        "closest_pushable(to)" =
          "heads(::to & mutable() & ~description(exact:\" \") & (~empty() | merges()))";
        "default()" = "coalesce(trunk(),root())::present(@) | ancestors(visible_heads() & recent(), 5)";
        "recent()" = "committer_date(after:\" 1 month ago \")";
      };
      template-aliases = {
        "format_short_cryptographic_signature(sig)" = ''
          if(sig,
            sig.status(),
            "(no sig)",
          )
        '';
        "format_short_change_id_with_hidden_and_divergent_info(id)" = ''
          id.shortest(6)
        '';
      };
    };
  };
}
