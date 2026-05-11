{ inputs, self, ... }:
{
  flake.nixosConfigurations.hostSponge = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.configSponge
      self.nixosModules.hardwareSponge
    ];
  };

  flake.nixosModules.configSponge =
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
        self.nixosModules.desktop
        self.nixosModules.audio
        self.nixosModules.bluetooth
        self.nixosModules.developer
        self.nixosModules.productivity

        self.nixosModules.diskoSponge
      ];

      preferences.user.name = "wallago";

      home-manager.users.${userName} = {
        imports = [
          self.homeModules.general

          self.homeModules.ai
          self.homeModules.desktop
          self.homeModules.developer
          self.homeModules.productivity
        ];

        preferences.user.name = userName;
      };
    };
}
