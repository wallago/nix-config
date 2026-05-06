{ self, ... }:
{
  flake.nixosModules.general = {
    imports = [
      self.nixosModules.base
      self.nixosModules.nix
      self.nixosModules.home-manager
      self.nixosModules.boot
      self.nixosModules.user
      self.nixosModules.secrets
      self.nixosModules.security
      self.nixosModules.networking

      self.nixosModules.impermanence
      self.nixosModules.shell
      self.nixosModules.locale
      self.nixosModules.netrc
      self.nixosModules.direnv
      self.nixosModules.nix-ld
    ];
  };

  flake.homeModules.general = {
    imports = [
      self.homeModules.base
      self.homeModules.secrets
      self.homeModules.user
      self.homeModules.networking

      self.homeModules.shell
      self.homeModules.editor
    ];

    home = {
      stateVersion = "26.05";
    };

    programs.home-manager.enable = true;
  };
}
