{ inputs, self, ... }:
{
  flake.nixosConfigurations.sponge = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.hostSponge
    ];
  };

  flake.nixosModules.hostSponge = {
    imports = [
      self.nixosModules.general

      self.nixosModules.userWallago
      self.nixosModules.nvidia

      self.diskoConfigurations.hostSponge
    ];

    home-manager.users.wallago = {
      imports = [
        self.homeModules.general

        self.homeModules.wallago
      ];
    };
  };
}
