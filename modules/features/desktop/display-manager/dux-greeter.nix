{
  flake.nixosModules.duxGreeter =
    { config, ... }:
    let
      inherit (config.preferences.user) name;
      inherit (config.services.xserver) xkb;
    in
    {
      services.displayManager.dux-greeter = {
        enable = true;
        compositor = {
          name = "niri";
          # The host's login layout (services.xserver.xkb), as SDDM used
          customConfig = ''
            input {
                keyboard {
                    xkb {
                        layout "${xkb.layout}"
                        variant "${xkb.variant}"
                    }
                }
            }
            hotkey-overlay {
                skip-at-startup
            }
          '';
        };
        # Copy DMS settings, session (wallpaper) and colors so it looks like the lock screen
        configHome = "/home/${name}";
      };

      environment.persistence."/persist".directories = [
        {
          directory = "/var/lib/dms-greeter";
          user = "dms-greeter";
          group = "dms-greeter";
          mode = "0750";
        }
      ];
    };
}
