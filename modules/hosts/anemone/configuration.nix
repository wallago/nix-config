{ inputs, self, ... }:
{
  flake.nixosConfigurations.anemone = inputs.nixos-raspberrypi.lib.nixosSystem {
    inherit (inputs) nixpkgs;
    specialArgs = {
      hostName = "anemone";
      inherit self;
    };
    modules = [
      self.nixosModules.configAnemone
      self.nixosModules.hardwareAnemone
    ];
  };

  flake.nixosModules.configAnemone =
    { config, pkgs, ... }:
    let
      userName = config.preferences.user.name;
    in
    {
      imports = [
        self.nixosModules.general

        self.nixosModules.userWallago
        self.nixosModules.secretsAnemone

        self.nixosModules.wireguardClient
        self.nixosModules.disko

        inputs.nixos-raspberrypi.nixosModules.raspberry-pi-5.base
        inputs.nixos-raspberrypi.nixosModules.raspberry-pi-5.bluetooth
      ];

      environment.systemPackages = [
        pkgs.python3 # SSH Tunnel
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
