{
  flake.nixosModules.ssh = {
    services.openssh = {
      enable = true;
      ports = [ 2222 ];
      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "no";
        LogLevel = "VERBOSE";
      };
    };

    networking.firewall.allowedTCPPorts = [ 2222 ];
  };

  flake.homeModules.ssh = {
    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;
      settings."*" = {
        hashKnownHosts = true;
        serverAliveInterval = 60;
      };
    };
  };
}
