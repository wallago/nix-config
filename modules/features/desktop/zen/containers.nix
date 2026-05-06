{
  flake.homeModules.zenContainers = {
    programs.zen-browser.profiles.default = {
      containersForce = true; # Delete containers not declared here
      containers = {
        Personal = {
          color = "purple";
          icon = "fingerprint";
          id = 1;
        };
        Work = {
          color = "blue";
          icon = "briefcase";
          id = 2;
        };
        Shopping = {
          color = "yellow";
          icon = "dollar";
          id = 3;
        };
      };
    };
  };
}
