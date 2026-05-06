{
  flake.homeModules.zenProfiles = {
    programs.zen-browser.profiles.default.settings = {
      "zen.workspaces.continue-where-left-off" = true;
      "zen.view.compact.hide-tabbar" = true;
      "zen.urlbar.behavior" = "float";
      "zen.welcome-screen.seen" = true;
    };
  };
}
