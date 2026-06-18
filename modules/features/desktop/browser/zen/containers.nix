{
  flake.homeModules.zenContainers =
    let
      perso = {
        Personal = {
          color = "red";
          icon = "fingerprint";
          id = 1;
        };
        Dev = {
          color = "purple";
          icon = "circle";
          id = 2;
        };
        Shopping = {
          color = "green";
          icon = "dollar";
          id = 4;
        };
      };
      work = {
        Work = {
          color = "blue";
          icon = "briefcase";
          id = 3;
        };

      };
    in
    {
      programs.zen-browser.profiles = {
        perso = {
          containersForce = true; # Delete containers not declared here
          containers = perso;
        };
        work = {
          containersForce = true; # Delete containers not declared here
          containers = work;
        };
        default = {
          containersForce = true; # Delete containers not declared here
          containers = perso // work;
        };
      };
    };
}
