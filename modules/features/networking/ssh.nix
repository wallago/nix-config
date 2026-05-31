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

  flake.homeModules = {
    ssh = {
      programs.ssh = {
        enable = true;
        enableDefaultConfig = false;
        settings."*" = {
          hashKnownHosts = true;
          serverAliveInterval = 60;
        };
      };
    };
    sshWg0 = {
      programs.ssh.settings = {
        coral = {
          hostname = "10.100.0.1";
          port = 2222;
          user = "wallago";
          setEnv = "TERM=xterm-256color";
        };
        sponge = {
          hostname = "10.100.0.3";
          port = 2222;
          user = "wallago";
        };
        squid = {
          hostname = "10.100.0.3";
          port = 2222;
          user = "wallago";
        };
      };
    };
  };
}
