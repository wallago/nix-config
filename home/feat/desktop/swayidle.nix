{ pkgs, lib, config, ... }:
let
  swaylock = lib.getExe config.programs.swaylock.package;
  hyprctl = lib.getExe config.wayland.windowManager.hyprland.package;
  pgrep = lib.getExe' pkgs.procps "pgrep";
  swaymsg = lib.getExe config.wayland.windowManager.sway.package;
  isLocked = "${pgrep} -x ${swaylock}";
  lockTime = 4 * 60;

  # Makes two timeouts: one for when the screen is not locked (lockTime+timeout) and one for when it is.
  afterLockTimeout = { timeout, command, resumeCommand ? null, }: [
    {
      timeout = lockTime + timeout;
      inherit command resumeCommand;
    }
    {
      command = "${isLocked} && ${command}";
      inherit resumeCommand timeout;
    }
  ];
in {
  services.swayidle = {
    enable = true;
    systemdTarget = "graphical-session.target";
    timeouts =
      # Lock screen
      [{
        timeout = lockTime;
        command =
          "${swaylock} -i ${config.wallpaper} --daemonize --grace 15 --grace-no-mouse";
      }] ++
      # Turn off displays (hyprland)
      (lib.optionals config.wayland.windowManager.hyprland.enable
        (afterLockTimeout {
          timeout = 40;
          command = "${hyprctl} dispatch dpms off";
          resumeCommand = "${hyprctl} dispatch dpms on";
        })) ++
      # Turn off displays (sway)
      (lib.optionals config.wayland.windowManager.sway.enable
        (afterLockTimeout {
          timeout = 40;
          command = "${swaymsg} 'output * dpms off'";
          resumeCommand = "${swaymsg} 'output * dpms on'";
        }));
  };
}
