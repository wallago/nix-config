{ self, ... }:
{
  flake.nixosModules.ssh =
    { config, pkgs, ... }:
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

      environment.systemPackages = with pkgs; [ waypipe ];

      networking.firewall.allowedTCPPorts = [ 2222 ];

      users.users.${userName}.openssh.authorizedKeys.keys = cfg.authorizedSshKeys ++ [
        # sponge
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIyPVvllSJcM+yJNaCIAg+Xied2gg8zuHPuieMtWTR7b"
        # squid
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMgZLJu6Us/PBZsLGuWSg1viq96m7ryJcuZdKHrKeAsq"
      ];
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
