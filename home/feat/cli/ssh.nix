{ outputs, lib, config, ... }:
let
  nixosConfigs = builtins.attrNames outputs.nixosConfigurations;
  homeConfigs = map (n: lib.last (lib.splitString "@" n))
    (builtins.attrNames outputs.homeConfigurations);
  hostnames = lib.unique (homeConfigs ++ nixosConfigs);
in {
  programs.ssh = {
    enable = true;
    userKnownHostsFile =
      "${config.home.homeDirectory}/.ssh/known_hosts.d/hosts";
    matchBlocks = {
      net = {
        host = lib.concatStringsSep " "
          (lib.flatten (map (host: [ host ]) hostnames));
        remoteForwards = [{
          bind.address = "/%d/.gnupg-sockets/S.gpg-agent";
          host.address = "/%d/.gnupg-sockets/S.gpg-agent.extra";
        }];
      };
    };
  };
}
