{ inputs, ... }:
{
  imports = [ inputs.nix-topology.flakeModule ];

  # Per-host NixOS module — hosts import this so the flakeModule picks them up.
  flake.nixosModules.topology = inputs.nix-topology.nixosModules.default;

  # Global facts Nix can't introspect: router, ISP box, the LANs.
  perSystem.topology.modules = [
    {
      networks = {
        isp.name = "ISP LAN";
        isp.cidrv4 = "192.168.1.0/24";
        home.name = "Home LAN";
        home.cidrv4 = "192.168.10.0/24";
        wg.name = "WireGuard mesh";
        wg.cidrv4 = "10.100.0.0/24";
      };
      nodes.rutx11 = {
        deviceType = "router";
        interfaces.lan.network = "home";
      };
      nodes.ispbox.deviceType = "device";
    }
  ];
}
