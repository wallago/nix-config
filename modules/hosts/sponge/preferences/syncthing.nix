{
  flake.nixosModules.preferencesSyncthingSponge =
    { config, ... }:
    {
      preferences.syncthing = {
        cert = config.sops.secrets."syncthing-cert".path;
        key = config.sops.secrets."syncthing-key".path;
        guiPasswordFile = config.sops.secrets."syncthing-password".path;
        devices = {
          coral = {
            id = "DTVJZPN-EZ4LYVA-AXHJGJ2-RX7HV2B-7JSVDIB-OMRKK6X-YJZMKDY-RVCKOQL";
            addresses = [ "tcp://10.100.0.1:22000" ];
          };
          squid.id = "";
          worm = {
            id = "VECK7WJ-R4CXSHS-RWOGRLH-RTBA42P-M2SZKEY-AIBSAEQ-A3U5QYG-UNY6WAB";
            addresses = [ "tcp://10.100.0.6:22000" ];
          };
        };
      };
    };
}
