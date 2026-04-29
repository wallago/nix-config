{ inputs, self, ... }:
{
  flake.nixosConfigurations.sponge = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.hostSponge
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
}
