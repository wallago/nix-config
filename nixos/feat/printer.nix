{ pkgs, ... }: {
  # Manage print http://localhost:631/

  # Print ip ipp://192.168.100.232/ipp/print

  # Nmap scan report for 192.168.100.232
  # Host is up (0.019s latency).
  # Not shown: 995 closed tcp ports (conn-refused)
  # PORT     STATE SERVICE
  # 80/tcp   open  http
  # 443/tcp  open  https
  # 515/tcp  open  printer
  # 631/tcp  open  ipp
  # 9100/tcp open  jetdirect

  # sudo lpadmin -p Canon_TS5100 -E -v ipp://192.168.10.122/ipp/print -m everywhere
  services.printing = {
    enable = true;
    drivers = with pkgs; [ hplip gutenprint ];
  };

  # Managing printers and print jobs on Linux and other UNIX-like operating systems.
  systemd.services.cups.serviceConfig = {
    NoNewPrivileges = true;
    ProtectSystem = "full";
    ProtectHome = true;
    ProtectKernelModules = true;
    ProtectKernelTunables = true;
    ProtectKernelLogs = true;
    ProtectControlGroups = true;
    ProtectHostname = true;
    ProtectClock = true;
    ProtectProc = "invisible";
    RestrictRealtime = true;
    RestrictNamespaces = true;
    RestrictSUIDSGID = true;
    RestrictAddressFamilies =
      [ "AF_UNIX" "AF_NETLINK" "AF_INET" "AF_INET6" "AF_PACKET" ];

    MemoryDenyWriteExecute = true;
    SystemCallFilter = [
      "~@clock"
      "~@reboot"
      "~@debug"
      "~@module"
      "~@swap"
      "~@obsolete"
      "~@cpu-emulation"
    ];
    SystemCallArchitectures = "native";
    LockPersonality = true;
  };
}
