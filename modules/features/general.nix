{ self, ... }:
{
  flake.nixosModules.general = {
    imports = [
      self.nixosModules.nixosOptions
      self.nixosModules.nix
      self.nixosModules.home-manager
      self.nixosModules.boot
      self.nixosModules.user
      self.nixosModules.security
      self.nixosModules.networking

      self.nixosModules.impermanence
      self.nixosModules.shell
      self.nixosModules.locale
      self.nixosModules.pager
      self.nixosModules.topology
    ];
  };

  flake.homeModules.general = {
    imports = [
      self.homeModules.homeOptions
      self.homeModules.user
      self.homeModules.networking

      self.homeModules.impermanence
      self.homeModules.shell
      self.homeModules.pager
    ];

    home = {
      stateVersion = "26.11";
    };

    programs.home-manager.enable = true;
  };
}
