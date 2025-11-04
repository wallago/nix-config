{ config, ... }: {
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
      };
      # signing = {
      #   backend = "gpg";
      #   behaviour =
      #     if config.programs.git.signing.signByDefault then "own" else "never";
      #   key = config.programs.git.signing.key;
      # };
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
}
