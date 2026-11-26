{ inputs, self, ... }:
{
  flake.nixosConfigurations.cuttlefish = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = {
      hostName = "cuttlefish";
      inherit self;
    };
    modules = [
      self.nixosModules.configCuttlefish
      self.nixosModules.hardwareCuttlefish
    ];
  };

  flake.nixosModules.configCuttlefish =
    { config, ... }:
    let
      userName = config.preferences.user.name;
    in
    {
      imports = [
        self.nixosModules.general
        self.nixosModules.personal

        self.nixosModules.userWallago
        self.nixosModules.secretsCuttlefish

        self.nixosModules.intel
        self.nixosModules.wireguardClient

        self.nixosModules.disko
        self.diskoConfigurations.hostCuttlefish
      ];

      preferences.user.name = "wallago";
      home-manager.users.${userName} = {
        imports = [
          self.homeModules.general
          self.homeModules.personal
        ];
        preferences.user.name = userName;
      };
    };
}
