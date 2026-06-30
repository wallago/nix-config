{ inputs, ... }:
{
  imports = [ inputs.nix-topology.flakeModule ];

  # Per-host NixOS module — hosts import this so the flakeModule picks them up.
  flake.nixosModules.topology = inputs.nix-topology.nixosModules.default;

  # Global facts Nix can't introspect: router, ISP box, the LANs.
  perSystem.topology.modules = [
    (
      { lib, ... }:
      let
        # NixOS hosts that live behind the router on the Home LAN.
        homeHosts = [
          "coral"
          "krill"
          "sponge"
        ];

        # WireGuard mesh addresses (coral is the hub/server).
        wgAddr = {
          coral = "10.100.0.1";
          squid = "10.100.0.2";
          sponge = "10.100.0.3";
          cuttlefish = "10.100.0.4";
          krill = "10.100.0.5";
        };

        # WireGuard mesh interface for any host with a wg address.
        # Clients connect to the coral hub; coral itself is the center.
        wgIface =
          host:
          lib.optionalAttrs (wgAddr ? ${host}) {
            wg0 = {
              virtual = true;
              network = "wg";
              addresses = [ "${wgAddr.${host}}/24" ];
              physicalConnections = lib.optional (host != "coral") {
                node = "coral";
                interface = "wg0";
              };
            };
          };
      in
      {
        networks = {
          isp.name = "ISP LAN";
          isp.cidrv4 = "192.168.1.0/24";
          home.name = "Home LAN";
          home.cidrv4 = "192.168.10.0/24";
          wg.name = "WireGuard mesh";
          wg.cidrv4 = "10.100.0.0/24";
        };

        nodes = {
          # Upstream, so the ISP box has something to plug into.
          internet = {
            deviceType = "internet";
            interfaces.wan = { };
          };

          # ISP-provided ethernet box (modem/router).
          ispbox = {
            deviceType = "device";
            interfaces = {
              wan.physicalConnections = [
                {
                  node = "internet";
                  interface = "wan";
                }
              ];
              lan = {
                network = "isp";
                physicalConnections = [
                  {
                    node = "rutx11";
                    interface = "wan";
                  }
                ];
              };
            };
          };

          # Teltonika RUTX11: WAN on the ISP LAN, LAN on the Home LAN.
          rutx11 = {
            deviceType = "router";
            interfaces = {
              wan.network = "isp";
              lan.network = "home";
            };
          };
        }
        // {
          squid.interfaces = wgIface "squid";
          cuttlefish.interfaces = wgIface "cuttlefish";
        }
        // lib.genAttrs homeHosts (host: {
          interfaces = {
            lan = {
              network = "home";
              physicalConnections = [
                {
                  node = "rutx11";
                  interface = "lan";
                }
              ];
            };
          }
          // wgIface host;
        });
      }
    )
  ];
}
