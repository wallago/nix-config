{ self, ... }:
{
  flake.nixosModules.wireguardClient =
    { config, lib, ... }:
    let
      cfg = config.preferences.wireguard.client;
    in
    {
      imports = [
        self.nixosModules.wireguardClientOptions
      ];

      networking.wg-quick.interfaces = lib.mapAttrs (_: iface: {
        inherit (iface) configFile;
      }) cfg.interfaces;
    };
}
