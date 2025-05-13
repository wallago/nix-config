{ config, ... }: {
  home.persistence = {
    "/persist/${config.home.homeDirectory}".directories = [ "Mail/" ];
  };

  accounts.email.maildirBasePath = "Mail";

  programs.mbsync.enable = true;
  programs.msmtp.enable = true;

  systemd.user.timers.mbsync = {
    Unit = { Description = "Automatic mbsync synchronization"; };
    Timer = {
      OnBootSec = "30";
      OnUnitActiveSec = "5m";
    };
    Install = { WantedBy = [ "timers.target" ]; };
  };
}
