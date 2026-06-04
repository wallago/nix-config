{ inputs, self, ... }:
{
  flake.nixosConfigurations.sponge = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = {
      hostName = "sponge";
      inherit self;
    };
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
        self.nixosModules.wireguardClient

        self.nixosModules.diskoSponge
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

          self.homeModules.preferencesSessionSponge
          self.homeModules.preferencesWorkspacesSponge
          self.homeModules.preferencesMonitorsSponge
        ];

        preferences.user.name = userName;
      };
    };
}
