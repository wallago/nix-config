{ inputs, self, ... }:
{
  flake.nixosConfigurations.sponge = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.hostSponge
      self.nixosModules.hostSpongeHardware
    ];
  };

  flake.nixosModules.hostSponge =
    { config, ... }:
    let
      userName = config.preferences.user.name;
    in
    {
      imports = [
        self.nixosModules.general

        self.nixosModules.userWallago
        self.nixosModules.secretsSponge

        self.nixosModules.nvidia
        self.nixosModules.vmNix
        self.nixosModules.gaming

        self.nixosModules.diskoSponge
      ];

      preferences.user.name = "wallago";

      home-manager.users.${userName} = {
        imports = [
          self.homeModules.general

          self.homeModules.ai
        ];

        preferences.user.name = userName;
      };
    };
}
