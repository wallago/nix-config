{ config, ... }:
let
  endpoint = config.sops.secrets."wg-server-ip".path;
  port = 51820;
  serverPublicKey = "FoiHQJLNM4aCmuvf2g2Mb6wqe8kU00AqWd7hGvNLZzY=";
in
{
  networking = {
    firewall = {
      allowedUDPPorts = [ port ];
    };
    wireguard.interfaces = {
      wg0 = {
        ips = [ config.wg-client.ip ];
        listenPort = port;
        privateKeyFile = config.wg-client.privateKeyFile;
        peers = [
          {
            publicKey = serverPublicKey;
            allowedIPs = [ "0.0.0.0/0" ];
            endpoint = "${endpoint}:51820";
            persistentKeepalive = 25;
          }
        ];
      };
    };
  };

  sops.secrets."wg-server-ip" = {
    sopsFile = ../common/secrets.yaml;
    format = "yaml";
  };
}
