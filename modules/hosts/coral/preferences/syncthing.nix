{
  flake.nixosModules.preferencesSyncthingCoral =
    { config, ... }:
    {
      preferences.syncthing = {
        cert = config.sops.secrets."syncthing-cert".path;
        key = config.sops.secrets."syncthing-key".path;
        guiPasswordFile = config.sops.secrets."syncthing-password".path;
        devices = {
          sponge = {
            id = "VU4ODZ4-RJGOBR7-KQO32MG-IPQCFLB-AFH3SCZ-XHWUSVY-YD32PYN-4S2GPQR";
            addresses = [ "tcp://10.100.0.3:22000" ];
          };
          squid = {
            id = "SARRURG-4MGEJY6-7I6E4WG-KNF2Y2M-H7AO7A6-VPZA66Z-BWANK2E-6WMY3A3";
            addresses = [ "tcp://10.100.0.2:22000" ];
          };
          worm = {
            id = "VECK7WJ-R4CXSHS-RWOGRLH-RTBA42P-M2SZKEY-AIBSAEQ-A3U5QYG-UNY6WAB";
            addresses = [ "tcp://10.100.0.6:22000" ];
          };
        };
      };
    };
}
