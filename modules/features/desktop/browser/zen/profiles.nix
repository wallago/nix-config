{
  flake.homeModules.zenProfiles =
    let
      commonSettings = {
        "zen.workspaces.continue-where-left-off" = true;
        "zen.view.compact.hide-tabbar" = true;
        "zen.urlbar.behavior" = "float";
        "zen.welcome-screen.seen" = true;
      };
    in
    {
      programs.zen-browser.profiles = {
        default = {
          id = 0;
          isDefault = true;
          settings = commonSettings;
        };
        perso = {
          id = 1;
          settings = commonSettings;
        };
        work = {
          id = 2;
          settings = commonSettings;
        };
      };
    };
}
