{
  flake.nixosModules.gamemode =
    { pkgs, config, ... }:
    {
      programs.gamemode = {
        enable = true;
        settings = {
          general = {
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
