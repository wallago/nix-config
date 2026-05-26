{ self, ... }:
{
  flake.nixosModules.wireguardClient =
    { config, ... }:
    let
      cfg = config.preferences.wireguard.client;
    in
    {
      imports = [
        self.nixosModules.wireguardClientOptions
      ];

      networking.wg-quick.interfaces = cfg.interfaces;
    };
}
