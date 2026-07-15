{ self, ... }: {
  flake.nixosModules.preferencesWireguardCoral =
    { config, lib, ... }:
    let
      inherit (self.lib) networks;
      peersFor =
        net:
        lib.mapAttrsToList (_: host: {
          inherit (host) publicKey;
          allowedIPs = [ "${host.ip}/32" ];
        }) (removeAttrs net.hosts [ "coral" ]);
    in
    {
      preferences.wireguard.server = {
        externalInterface = "enp114s0";
        firewall.extraCommands = ''
          # wg1 is untrusted: never let it reach wg0 or the internet via NAT
          iptables -A FORWARD -i wg1 -o wg0 -j DROP
          iptables -A FORWARD -i wg1 -o enp114s0 -j DROP

          # within wg1: only squid/sponge may initiate; replies allowed back
          iptables -A FORWARD -i wg1 -o wg1 -m state --state ESTABLISHED,RELATED -j ACCEPT
          iptables -A FORWARD -i wg1 -o wg1 -s ${networks.wg1.hosts.squid.ip},${networks.wg1.hosts.sponge.ip} -p tcp --dport 2222 -j ACCEPT
          iptables -A FORWARD -i wg1 -o wg1 -j DROP
        '';
        interfaces = {
          wg0 = {
            ip = "${networks.wg0.hosts.coral.ip}/24";
            listenPort = networks.wg0.port;
            privateKeyFile = config.sops.secrets."wg0-sk".path;
            peers = peersFor networks.wg0;
          };
          wg1 = {
            ip = "${networks.wg1.hosts.coral.ip}/24";
            listenPort = networks.wg1.port;
            privateKeyFile = config.sops.secrets."wg1-sk".path;
            peers = peersFor networks.wg1;
          };
        };
      };
    };
}
