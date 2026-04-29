{ inputs, self, ... }:
{
  flake.nixosConfigurations.sponge = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.hostSponge
    ];
  };

  flake.nixosModules.hostSponge =
    { config, ... }:
      self.nixosModules.general

      self.nixosModules.userWallago
      self.nixosModules.nvidia
      imports = [
        self.nixosModules.general

        self.nixosModules.userWallago
        self.nixosModules.secretsSponge

    home-manager.users.wallago = {
      imports = [
        self.homeModules.general

        self.nixosModules.diskoSponge
      ];

      preferences.user.name = "wallago";

      home-manager.users.${userName} = {
        imports = [
          self.homeModules.general
        ];

        preferences.user.name = userName;
      };
    };
  };
}
