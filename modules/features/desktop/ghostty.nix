{
  flake.homeModules.ghostty = {
    programs.ghostty = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        window-padding-x = "6";
        window-padding-y = "4";
        confirm-close-surface = false;
      };
    };
  };
}
