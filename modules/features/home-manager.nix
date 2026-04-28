{ inputs, ... }:
{
  flake.nixosModules.home-manager = {
    imports = [ inputs.home-manager.nixosModules.home-manager ];

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "hm-bak";
    };
  };

  flake.homeModules.general = {
    home = {
      stateVersion = "26.05";
    };
    programs.home-manager.enable = true;
  };
}
