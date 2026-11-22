{
  flake.nixosModules.duxGreeter =
    { config, ... }:
    let
      inherit (config.preferences.user) name keyboard;
    in
    {
      services.displayManager.dux-greeter = {
        enable = true;
        compositor = {
          name = "niri";
          # Same keyboard layouts as the niri session, so the password types the same
          customConfig = ''
            input {
                keyboard {
                    xkb {
                        layout "us,${keyboard.layout}"
                        variant ",${keyboard.variant}"
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
