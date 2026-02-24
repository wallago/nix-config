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
        show-cryptographic-signatures = true;
        style = "square";
        diff-editor = "nvim -c DiffEditor $left $right $output";
        pager = "less -FRX";
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
