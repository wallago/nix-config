{ config, pkgs, ... }:
let
  wg0 = {
    sk = config.sops.secrets."wg0-sk".path;
    mask = "10.100.0";
    port = 51820;
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
  };
  wg1 = {
    sk = config.sops.secrets."wg1-sk".path;
    mask = "10.200.0";
    port = 51840;
    squid = {
      publicKey = "XOr3H2ae1jdm+k2TzkSArirfa57DSpM3wTEXrvLkzBg=";
      allowedIPs = [ "${wg1.mask}.2/32" ];
    };
    # sponge = {
    #   publicKey = "GHHvXL/R+e/7ofeO01PC5reIrY0W7recbK2KzBjnaXg=";
    #   allowedIPs = [ "${wg1.mask}.3/32" ];
    # };
    leapfrog = {
      publicKey = "i1PhzPWel1imDtTxqM+16ScqDgBAw+/AFXTLNA3h+G8=";
      allowedIPs = [ "${wg1.mask}.4/32" ];
    };
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
        privateKeyFile = wg0.sk;
        peers = [
          wg0.squid
          wg0.sponge
          wg0.cuttlefish
        ];
      };
      wg1 = {
        ips = [ "${wg1.mask}.1/24" ];
        listenPort = wg1.port;
        privateKeyFile = wg1.sk;
        peers = [
          wg1.squid
          # wg1.sponge
          wg1.leapfrog
        ];
      };
    };
  };

  sops.secrets."wg0-sk" = {
    sopsFile = ../secrets.yaml;
  };

  sops.secrets."wg1-sk" = {
    sopsFile = ../secrets.yaml;
  };
}
