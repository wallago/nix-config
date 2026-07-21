{ self, ... }: {
  flake.nixosModules.preferencesWireguardCoral =
    { config, lib, ... }:
    let
      inherit (self.lib) wireguard;
      wg1Admins = lib.concatStringsSep "," [
        wireguard.wg1.hosts.squid.ip
        wireguard.wg1.hosts.sponge.ip
      ];
      wg1AccessRules = lib.concatMapStringsSep "\n" (
        host:
        "iptables -A wg1-fwd -o wg1 -s ${wg1Admins} -d ${host.ip} "
        + "-p tcp -m multiport --dports ${lib.concatMapStringsSep "," toString host.ports} -j ACCEPT"
      ) (lib.attrValues (lib.filterAttrs (_: h: h ? ports) wireguard.wg1.hosts));
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
        firewall = {

          # extraCommands runs on EVERY firewall (re)start, and iptables -A only ever
          # appends. To avoid stacking duplicate rules, we put all our wg1 logic in
          # one chain (wg1-fwd) that we wipe clean at the start of each run.
          extraCommands = ''
            # Create chain the first time; if it already exists, empty it (-F) so we
            # rebuild from scratch instead of appending on top of the old rules.
            iptables -N wg1-fwd 2>/dev/null || iptables -F wg1-fwd

            # Divert everything arriving on wg1 into wg1-fwd. -C tests whether the jump
            # is already present, so we add it only once (this line is NOT flushed).
            iptables -C FORWARD -i wg1 -j wg1-fwd 2>/dev/null || iptables -A FORWARD -i wg1 -j wg1-fwd

            # --- from here, rules go into wg1-fwd, NOT FORWARD ---

            # wg1 is untrusted: never let it reach wg0 or the internet via NAT
            iptables -A wg1-fwd -o wg0 -j DROP
            iptables -A wg1-fwd -o enp114s0 -j DROP

            # Allow replies back to connections squid/sponge already opened.
            iptables -A wg1-fwd -o wg1 -m state --state ESTABLISHED,RELATED -j ACCEPT

            # Only squid/sponge may INITIATE, and only to these ports.
            ${wg1AccessRules}

            # Anything else between wg1 peers: dropped.
            iptables -A FORWARD -i wg1 -o wg1 -j DROP
          '';

          # extraStopCommands runs on firewall reload/stop. Detach + delete our chain so
          # a reload REPLACES our rules instead of leaving old copies behind.
          extraStopCommands = ''
            iptables -D FORWARD -i wg1 -j wg1-fwd 2>/dev/null || true
            iptables -F wg1-fwd 2>/dev/null || true
            iptables -X wg1-fwd 2>/dev/null || true
          '';
        };
        interfaces = {
          wg0 = {
            ip = "${wireguard.wg0.hosts.coral.ip}/24";
            listenPort = wireguard.wg0.port;
            privateKeyFile = config.sops.secrets."wg0-sk".path;
            peers = peersFor wireguard.wg0;
          };
          wg1 = {
            ip = "${wireguard.wg1.hosts.coral.ip}/24";
            listenPort = wireguard.wg1.port;
            privateKeyFile = config.sops.secrets."wg1-sk".path;
            peers = peersFor wireguard.wg1;
          };
        };
      };
    };
}
