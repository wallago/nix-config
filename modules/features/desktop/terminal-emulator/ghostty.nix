{
  flake.homeModules.ghostty = {
    programs.ghostty = {
      enable = true;
      enableFishIntegration = true;

      settings = {
        theme = "Catppuccin Mocha";
        window-padding-x = "6";
        window-padding-y = "4";
        window-decoration = false;
        confirm-close-surface = false;
      };
    };
  };
}
