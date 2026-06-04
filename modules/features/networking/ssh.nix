{ self, ... }:
{
  flake.nixosModules.ssh =
    { config, ... }:
    let
      userName = config.preferences.user.name;
      cfg = config.preferences.ssh;
    in
    {
      imports = [ self.nixosModules.sshOptions ];

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

      users.users.${userName}.openssh.authorizedKeys.keys = cfg.authorizedSshKeys ++ [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILKMPubEMjwYfkQl5ofu6MUbZYwSmInB+M1gVdnMIidj"
      ];
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
        cuttlefish = {
          hostname = "10.100.0.4";
          port = 2222;
          user = "wallago";
          setEnv = "TERM=xterm-256color";
        };
      };
    };
  };
}
