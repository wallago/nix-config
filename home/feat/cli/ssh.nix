{ outputs, lib, config, ... }:
let
  nixosConfigs = builtins.attrNames outputs.nixosConfigurations;
  homeConfigs = map (n: lib.last (lib.splitString "@" n))
    (builtins.attrNames outputs.homeConfigurations);
  hostnames = lib.unique (homeConfigs ++ nixosConfigs);
in {
  # Persisting known_hosts with impermance is wonky, as SSH sometimes
  # overwrites it. My workaround is to make a known_hosts.d directory instead,
  # which is persisted.
  home.persistence = {
    "/persist/${config.home.homeDirectory}".directories =
      [ ".ssh/known_hosts.d/" ];
  };

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "*" = {
        forwardAgent = false;
        hashKnownHosts = true;
        serverAliveInterval = 60;
      };
      net = {
        userKnownHostsFile =
          "${config.home.homeDirectory}/.ssh/known_hosts.d/hosts";
        host = lib.concatStringsSep " "
          (lib.flatten (map (host: [ host ]) hostnames));
        remoteForwards = [{
          bind.address =
            "/${config.home.homeDirectory}/.gnupg-sockets/S.gpg-agent";
          host.address =
            "/${config.home.homeDirectory}/.gnupg-sockets/S.gpg-agent.extra";
        }];
      };
    };
  };
}

