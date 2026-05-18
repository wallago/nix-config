{
  flake.nixosModules.less = {
    programs.less = {
      enable = true;
      clearDefaultCommands = true;
      commands = {
        q = "quit";
        n = "back-screen"; # vim-ish: h = previous page
        o = "forw-screen"; # vim-ish: l = next page
        g = "goto-line";
        G = "goto-end";
      };
      envVariables = {
        LESS = "-R -F -X --mouse";
      };
    };
  };
}
