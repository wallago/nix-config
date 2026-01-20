{ config, pkgs, ... }:
let
  wg-pk = config.sops.secrets."wg-server-pk".path;
  wg0 = {
    mask = "10.100.0";
    port = 51820;
  };
  wg1 = {
    mask = "10.200.0";
    port = 51840;
  };
  squid = {
    publicKey = "CeGKBz6Xtuj/UaZqUc8u9/fQ53IH3L9uS+X8XRflj24=";
    allowedIPs = [ "${wg0.mask}.2/32" ];
  };
  sponge = {
    publicKey = "GHHvXL/R+e/7ofeO01PC5reIrY0W7recbK2KzBjnaXg=";
    allowedIPs = [ "${wg0.mask}.3/32" ];
  };
  cuttlefish = {
    publicKey = "gW+F/0uL2dDxzlN4Q836w17fiElhwqyk6ffdybR+Ikk=";
    allowedIPs = [ "${wg0.mask}.4/32" ];
  };
  leapfrog = {
    publicKey = "mS33jeYBD00npCUkQjKFFlXGpeMiXDe4GBMe35lPxm8=";
    allowedIPs = [ "${wg1.mask}.2/32" ];
  };
  externalInterface = "enp114s0";
in
{
  networking = {
    firewall = {
      allowedUDPPorts = [
        wg0.port
        wg1.port
      ];
    };
    nat = {
      enable = true;
      externalInterface = externalInterface;
      internalInterfaces = [
        "wg0"
        "wg1"
      ];
    };
    wireguard.interfaces = {
      wg0 = {
        ips = [ "${wg0.mask}.1/24" ];
        listenPort = wg0.port;
        privateKeyFile = wg-pk;
        peers = [
          squid
          sponge
          cuttlefish
        ];
      };
      wg1 = {
        ips = [ "${wg1.mask}.1/24" ];
        listenPort = wg1.port;
        privateKeyFile = wg-pk;
        peers = [
          leapfrog
        ];
      };
    };
  };

  sops.secrets."wg-server-pk" = {
    sopsFile = ../secrets.yaml;
    format = "yaml";
  };
}
