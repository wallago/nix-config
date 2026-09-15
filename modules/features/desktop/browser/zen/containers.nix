{
  flake.homeModules.zenContainers = {
    programs.zen-browser.profiles = {
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
          Shopping = {
            color = "green";
            icon = "dollar";
            id = 4;
          };
          Social = {
            color = "yellow";
            icon = "pet";
            id = 5;
          };
        };
      };
      secondary = {
        containersForce = true; # Delete containers not declared here
        containers = {
          Entertainment = {
            color = "red";
            icon = "chill";
            id = 1;
          };
        };
      };
    };
  };
}
