{
  flake.nixosModules.gamemode =
    { pkgs, config, ... }:
    {
      programs.gamemode = {
        enable = true;
        settings = {
          general = {
            desiredgov = "performance";
            softrealtime = "auto";
            inhibit_screensaver = 1;
            renice = 10;
          };
          custom = {
            start = "${pkgs.libnotify}/bin/notify-send 'GameMode started'";
            end = "${pkgs.libnotify}/bin/notify-send 'GameMode ended'";
          };
        };
      };

      users.users.${config.preferences.user.name}.extraGroups = [ "gamemode" ];
    };
}
