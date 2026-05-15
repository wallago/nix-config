{ self, ... }:
{
  flake.nixosModules.wireguardClient =

    { config, lib, ... }:
    {
      imports = [
        self.nixosModules.wireguardClientOptions
      ];

      networking.wg-quick.interfaces = lib.mapAttrs (name: _: {
        configFile = config.sops.templates."${name}.conf".path;
      }) config.preferences.wireguard.client.interfaces;
    };
}
