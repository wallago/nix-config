{
  flake.nixosModules.preferencesWireguardCoral =
    { config, ... }:
    {
      preferences.wireguard.server = {
        externalInterface = "enp114s0";
        firewall.extraCommands = ''
          # wg1 is untrusted: never let it reach wg0 or the internet via NAT
          iptables -A FORWARD -i wg1 -o wg0 -j DROP
          iptables -A FORWARD -i wg1 -o enp114s0 -j DROP

          # within wg1: only squid/sponge may initiate; replies allowed back
          iptables -A FORWARD -i wg1 -o wg1 -m state --state ESTABLISHED,RELATED -j ACCEPT
          iptables -A FORWARD -i wg1 -o wg1 -s 10.200.0.2,10.200.0.3 -p tcp --dport 2222 -j ACCEPT
          iptables -A FORWARD -i wg1 -o wg1 -j DROP
        '';
        interfaces = {
          wg0 = {
            ip = "10.100.0.1/24";
            listenPort = 51820;
            privateKeyFile = config.sops.secrets."wg0-sk".path;
            peers = [
              {
                # squid
                publicKey = "CeGKBz6Xtuj/UaZqUc8u9/fQ53IH3L9uS+X8XRflj24=";
                allowedIPs = [ "10.100.0.2/32" ];
              }
              {
                # sponge
                publicKey = "GHHvXL/R+e/7ofeO01PC5reIrY0W7recbK2KzBjnaXg=";
                allowedIPs = [ "10.100.0.3/32" ];
              }
              {
                # cuttlefish
                publicKey = "Bx8RvmvK2EpC41zqscX4zuw+qjYYWrPB3LrUxk8xg3k=";
                allowedIPs = [ "10.100.0.4/32" ];
              }
              {
                # krill
                publicKey = "b0TYc2kWNyWNv2HcXAv4FfF0ZKPotvoVz33gKmJuyTA=";
                allowedIPs = [ "10.100.0.5/32" ];
              }
              {
                # worm
                publicKey = "JTl7tlUtS6mKNwjJ0oGXT68XxJ7U8mQ+wb6m5sXxdT8=";
                allowedIPs = [ "10.100.0.6/32" ];
              }
            ];
          };
          wg1 = {
            ip = "10.200.0.1/24";
            listenPort = 51840;
            privateKeyFile = config.sops.secrets."wg1-sk".path;
            peers = [
              {
                # provision-iso
                publicKey = "Qfc0+PXgYKb7BnVFXObFRtsJT6lFXfhTzl6JDIJtVw4=";
                allowedIPs = [ "10.200.0.254/32" ];
              }
              {
                # squid
                publicKey = "XOr3H2ae1jdm+k2TzkSArirfa57DSpM3wTEXrvLkzBg=";
                allowedIPs = [ "10.200.0.2/32" ];
              }
              {
                # sponge
                publicKey = "OJYAx4VxGWMc73S0EModA/A8tRYYrdAq+lQnlPHNmgE=";
                allowedIPs = [ "10.200.0.3/32" ];
              }
              {
                # 4778
                publicKey = "i1PhzPWel1imDtTxqM+16ScqDgBAw+/AFXTLNA3h+G8=";
                allowedIPs = [ "10.200.0.4/32" ];
              }
              {
                # 4839
                publicKey = "dMpVKFGflmX9QzrBaCPa5Z2WUqJ1hC7QuvtFmq4w1lM=";
                allowedIPs = [ "10.200.0.5/32" ];
              }
              {
                # 4797
                publicKey = "p99A09tn8LOAJsAVPldf6+ZMmmOutYuph5LbB7akBFQ=";
                allowedIPs = [ "10.200.0.6/32" ];
              }
            ];
          };
        };
      };
    };
}
