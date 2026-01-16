{ config, pkgs, ... }:
let
  wg-pk = config.sops.secrets."wg-server-pk".path;
  squid = {
    publicKey = "CeGKBz6Xtuj/UaZqUc8u9/fQ53IH3L9uS+X8XRflj24=";
    allowedIPs = [ "10.100.0.2/32" ];
  };
  sponge = {
    publicKey = "GHHvXL/R+e/7ofeO01PC5reIrY0W7recbK2KzBjnaXg=";
    allowedIPs = [ "10.100.0.3/32" ];
  };
  cuttlefish = {
    publicKey = "gW+F/0uL2dDxzlN4Q836w17fiElhwqyk6ffdybR+Ikk=";
    allowedIPs = [ "10.100.0.4/32" ];
  };
in
{
  networking = {
    firewall = {
      allowedUDPPorts = [ 51820 ];
    };
    nat = {
      enable = true;
      externalInterface = "eth0";
      internalInterfaces = [ "wg0" ];
    };
    wireguard.interfaces.wg0 = {
      ips = [ "10.100.0.1/24" ];
      listenPort = 51820;
      # This allows the wireguard server to route your traffic to the internet and hence be like a VPN
      postSetup = ''
        ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s 10.100.0.0/24 -o eth0 -j MASQUERADE
      '';
      # This undoes the above command
      postShutdown = ''
        ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s 10.100.0.0/24 -o eth0 -j MASQUERADE
      '';
      privateKeyFile = wg-pk;
      peers = [
        squid
        sponge
        cuttlefish
      ];
    };
  };

  sops.secrets."wg-server-pk" = {
    sopsFile = ../secrets.yaml;
    format = "yaml";
  };
}
