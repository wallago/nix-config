{
  flake.homeModules.zenContainers = {
    programs.zen-browser.profiles.default = {
      containersForce = true; # Delete containers not declared here
      containers = {
        Personal = {
          color = "red";
          icon = "fingerprint";
          id = 1;
        };
        Work = {
          color = "blue";
          icon = "briefcase";
          id = 2;
        };
        Shopping = {
          color = "green";
          icon = "dollar";
          id = 3;
        };
      };
    };
  };
}
