{ inputs, self, ... }:
{
  flake.nixosConfigurations.sponge = inputs.nixpkgs.lib.nixosSystem {
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
        ];

        preferences.user.name = userName;

        preferences.monitors = {
          "DP-2" = {
            primary = true;
            mode = {
              width = 2560;
              height = 1440;
              refresh = 59.951;
            };
            scale = 1.0;
            position = {
              x = 0;
              y = 0;
            };
          };
          "DP-3" = {
            mode = {
              width = 1920;
              height = 1080;
              refresh = 239.760;
            };
            scale = 1.0;
            position = {
              y = 0;
              x = -1920;
            };
          };
          "HDMI-A-1" = {
            mode = {
              width = 2560;
              height = 1440;
              refresh = 59.951;
            };
            scale = 1.25;
            position = {
              y = -1152;
              x = 0;
            };
          };
        };

        preferences.workspace = {
          productivity = "DP-2";
          config = "DP-2";
          browser = "HDMI-A-1";
        };

        preferences.session = [
          {
            command = [
              "zen-beta"
            ];
            matchTitle = "zen-beta";
            workspace = "browser";
          }
          {
            command = [
              "ghostty"
              "--title=rss"
              "-e"
              "eilmeldung"
            ];
            matchAppId = "com.mitchellh.ghostty";
            matchTitle = "rss";
            workspace = "productivity";
          }
          {
            command = [
              "ghostty"
              "--title=config"
              "--working-directory=/home/wallago/nix-config"
              "-e"
              "vi"
            ];
            matchAppId = "com.mitchellh.ghostty";
            matchTitle = "config";
            workspace = "config";
          }
        ];
      };
    };
}
