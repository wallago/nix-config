{ inputs, self, ... }:
{
  flake.nixosConfigurations.squid = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = {
      hostName = "squid";
      inherit self;
    };
    modules = [
      self.nixosModules.configSquid
      self.nixosModules.hardwareSquid
    ];
  };

  flake.nixosModules.configSquid =
    { config, ... }:
    let
      userName = config.preferences.user.name;
    in
    {
      imports = [
        self.nixosModules.general

        self.nixosModules.userWallago
        self.nixosModules.secretsSquid

        self.nixosModules.intel
        self.nixosModules.vmNix
        self.nixosModules.gaming
        self.nixosModules.desktop
        self.nixosModules.audio
        self.nixosModules.bluetooth
        self.nixosModules.developer
        self.nixosModules.productivity
        self.nixosModules.wireguardClient
        self.nixosModules.battery
        self.nixosModules.syncthing

        self.nixosModules.diskoSquid
      ];

      # default keyboard at login level
      services.xserver.xkb = {
        layout = config.preferences.user.keyboard.layout;
        variant = config.preferences.user.keyboard.variant;
      };

      preferences.user.name = "wallago";
      home-manager.users.${userName} = {
        imports = [
          self.homeModules.general

          self.homeModules.ai
          self.homeModules.desktop
          self.homeModules.developer
          self.homeModules.productivity
          self.homeModules.gaming

          self.homeModules.sshWg0

          self.homeModules.preferencesSessionSquid
          self.homeModules.preferencesWorkspacesSquid
          self.homeModules.preferencesMonitorsSquid
        ];

        preferences.user = {
          name = userName;
        };
      };
    };
}
