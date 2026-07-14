{
  flake.homeModules.zenContainers = {
    programs.zen-browser.profiles = {
      secondary = {
        containersForce = true; # Delete containers not declared here
        containers = {
          Personal = {
            color = "red";
            icon = "fingerprint";
            id = 1;
          };
          Shopping = {
            color = "green";
            icon = "dollar";
            id = 4;
          };
        };
      };
      default = {
        containersForce = true; # Delete containers not declared here
        containers = {
          Dev = {
            color = "purple";
            icon = "circle";
            id = 2;
          };
          Work = {
            color = "blue";
            icon = "briefcase";
            id = 3;
          };
        };
      };
    };
  };
}
