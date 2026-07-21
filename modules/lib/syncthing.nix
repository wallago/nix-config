{ self, ... }: {
  flake.lib.syncthing =
    let
      hosts = self.lib.wireguard.wg0.hosts;
      port = 22000;
    in
    {
      inherit port;
      hosts = {
        coral = {
          id = "DTVJZPN-EZ4LYVA-AXHJGJ2-RX7HV2B-7JSVDIB-OMRKK6X-YJZMKDY-RVCKOQL";
          addresses = [ "tcp://${hosts.coral.ip}:${toString port}" ];
        };
        squid = {
          id = "SARRURG-4MGEJY6-7I6E4WG-KNF2Y2M-H7AO7A6-VPZA66Z-BWANK2E-6WMY3A3";
          addresses = [ "tcp://${hosts.squid.ip}:${toString port}" ];
        };
        sponge = {
          id = "VU4ODZ4-RJGOBR7-KQO32MG-IPQCFLB-AFH3SCZ-XHWUSVY-YD32PYN-4S2GPQR";
          addresses = [ "tcp://${hosts.sponge.ip}:${toString port}" ];
        };
        worm = {
          id = "VECK7WJ-R4CXSHS-RWOGRLH-RTBA42P-M2SZKEY-AIBSAEQ-A3U5QYG-UNY6WAB";
          addresses = [ "tcp://${hosts.worm.ip}:${toString port}" ];
        };
      };
    };
}
