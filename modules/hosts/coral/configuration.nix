{ inputs, self, ... }:
{
  flake.nixosConfigurations.coral = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = {
      hostName = "coral";
      inherit self;
    };
    modules = [
      self.nixosModules.configCoral
      self.nixosModules.hardwareCoral
    ];
  };

  flake.nixosModules.configCoral =
    { config, ... }:
    let
      userName = config.preferences.user.name;
    in
    {
      imports = [
        self.nixosModules.general

        self.nixosModules.userWallago
        self.nixosModules.secretsCoral

        self.nixosModules.intel
        self.nixosModules.wireguardServer
        self.nixosModules.miniflux
        self.nixosModules.syncthing
        self.nixosModules.nginxReverseProxy
        self.nixosModules.attic
        self.nixosModules.atuinServer
        self.nixosModules.atuinClient
        self.nixosModules.skimmer

        self.nixosModules.preferencesMinifluxCoral

        self.nixosModules.disko
      ];

      preferences.user.name = "wallago";
      home-manager.users.${userName} = {
        imports = [
          self.homeModules.general
        ];

        preferences.user = {
          name = userName;
        };
      };
    };
}
