{ self, ... }:
{
  flake.nixosModules.general = {
    imports = [
      self.nixosModules.base
      self.nixosModules.nix
      self.nixosModules.home-manager
      self.nixosModules.user
      self.nixosModules.secrets
      self.nixosModules.fish
    ];
  };

  flake.homeModules.general = {
    imports = [
      self.homeModules.base
      self.homeModules.secrets
      self.homeModules.fish
      self.homeModules.user
    ];

    home = {
      stateVersion = "26.05";
    };

    programs.home-manager.enable = true;
  };
}
