{
  flake.nixosModules.preferencesSyncthingSponge =
    { config, ... }:
    {
      preferences.syncthing = {
        cert = config.sops.secrets."syncthing-cert".path;
        key = config.sops.secrets."syncthing-key".path;
        guiPasswordFile = config.sops.secrets."syncthing-password".path;
        folders = {
          bagels = {
            name = "Bagels";
            devices = {
              coral = {
                id = "DTVJZPN-EZ4LYVA-AXHJGJ2-RX7HV2B-7JSVDIB-OMRKK6X-YJZMKDY-RVCKOQL";
                addresses = [ "tcp://10.100.0.1:22000" ];
              };
              squid = {
                id = "SARRURG-4MGEJY6-7I6E4WG-KNF2Y2M-H7AO7A6-VPZA66Z-BWANK2E-6WMY3A3";
                addresses = [ "tcp://10.100.0.2:22000" ];
              };
            };
          };
          notes = {
            name = "Notes";
            devices = {
              coral = {
                id = "DTVJZPN-EZ4LYVA-AXHJGJ2-RX7HV2B-7JSVDIB-OMRKK6X-YJZMKDY-RVCKOQL";
                addresses = [ "tcp://10.100.0.1:22000" ];
              };
              squid = {
                id = "SARRURG-4MGEJY6-7I6E4WG-KNF2Y2M-H7AO7A6-VPZA66Z-BWANK2E-6WMY3A3";
                addresses = [ "tcp://10.100.0.2:22000" ];
              };
            };
          };
        };
      };
    };
}
