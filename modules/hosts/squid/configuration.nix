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

        self.nixosModules.intel
        self.nixosModules.vmNix
        self.nixosModules.gaming
        self.nixosModules.desktop
        self.nixosModules.audio
        self.nixosModules.bluetooth
        self.nixosModules.developer
        self.nixosModules.productivity

        self.nixosModules.battery

        self.nixosModules.diskoSquid
      ];

      preferences.user.name = "wallago";

      # default keyboard at login level
      services.xserver.xkb = {
        layout = "us";
        variant = "colemak_dh";
      };

      home-manager.users.${userName} = {
        imports = [
          self.homeModules.general

          self.homeModules.ai
          self.homeModules.desktop
          self.homeModules.developer
          self.homeModules.productivity
        ];

        preferences.user.name = userName;

        preferences.monitors."DP-1" = {
          primary = true;
          mode = {
            width = 1920;
            height = 1080;
            refresh = 60.033;
          };
          scale = 1.5;
          position = {
            x = 0;
            y = 0;
          };
        };
      };
    };
}
