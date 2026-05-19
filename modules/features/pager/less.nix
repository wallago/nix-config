{
  flake.nixosModules.less = {
    programs.less = {
      enable = true;
      clearDefaultCommands = true;
      commands = {
        q = "quit";
        i = "back-line"; # previous line
        e = "forw-line"; # next line
        u = "back-screen"; # previous page
        y = "forw-screen"; # next page
        f = "back-scroll"; # previous half page
        p = "forw-scroll"; # next half page
        g = "goto-line";
        G = "goto-end";
        "/" = "forw-search";
        "?" = "back-search";
        h = "help";
        s = "status";
      };
      envVariables = {
        LESS = "-R -X --mouse";
      };
    };
  };
}
