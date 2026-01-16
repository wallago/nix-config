{ config, ... }:
let
  port = 51820;
  serverPublicKey = "FoiHQJLNM4aCmuvf2g2Mb6wqe8kU00AqWd7hGvNLZzY=";
in
{
  sops.secrets = {
    "wg-server-ip" = {
      sopsFile = ../common/secrets.yaml;
    };
    "wg-client-pk" = {
      sopsFile = ../../hosts/${config.networking.hostName}/secrets.yaml;
    };
  };

  sops.templates."wg0.conf" = {
    content = ''
      [Interface]
      PrivateKey = ${config.sops.placeholder."wg-client-pk"}
      Address = ${config.wg-client.ip}

      [Peer]
      PublicKey = ${serverPublicKey}
      AllowedIPs = 10.100.0.0/24
      Endpoint = ${config.sops.placeholder."wg-server-ip"}:${toString port}
      PersistentKeepalive = 25
    '';
  };

  networking.wg-quick.interfaces.wg0 = {
    configFile = config.sops.templates."wg0.conf".path;
  };
}
