{ inputs, self, ... }:
{
  flake.nixosConfigurations.krill = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = {
      hostName = "krill";
      inherit self;
    };
    modules = [
      self.nixosModules.configKrill
      self.nixosModules.hardwareKrill
    ];
  };

  flake.nixosModules.configKrill =
    { config, ... }:
    let
      userName = config.preferences.user.name;
    in
    {
      imports = [
        self.nixosModules.general

        self.nixosModules.userWallago
        self.nixosModules.secretsKrill

        self.nixosModules.intel
        self.nixosModules.wireguardClient
        self.nixosModules.githubRunners

        self.nixosModules.diskoKrill
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
