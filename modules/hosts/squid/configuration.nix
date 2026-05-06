{ inputs, self, ... }:
{
  flake.nixosConfigurations.squid = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.hostSquid
      self.nixosModules.hostSquidHardware
    ];
  };

  flake.nixosModules.hostSquid =
    { config, ... }:
    let
      userName = config.preferences.user.name;
    in
    {
      imports = [
        self.nixosModules.general

        self.nixosModules.userWallago
        self.nixosModules.secretsSquid

        self.nixosModules.nvidia
        self.nixosModules.vmNix
        self.nixosModules.gaming
        self.nixosModules.desktop
        self.nixosModules.audio
        self.nixosModules.bluetooth

        self.nixosModules.battery

        self.nixosModules.diskoSquid
      ];

      preferences.user.name = "wallago";

      home-manager.users.${userName} = {
        imports = [
          self.homeModules.general

          self.homeModules.ai
          self.homeModules.desktop
        ];

        preferences.user.name = userName;
      };
    };
}
