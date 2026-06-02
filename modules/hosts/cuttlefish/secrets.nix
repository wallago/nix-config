{
  flake.nixosModules.secretsCuttlefish =
    { config, lib, ... }:
    let
      ifaces = config.preferences.wireguard.client.interfaces;
    in
    {
      sops = {
        defaultSopsFile = ../../secrets/coral.yaml;
        secrets = lib.mkMerge [
          {
            wallago-password.neededForUsers = true;
          }
          (lib.mapAttrs' (name: _: {
            name = "${name}-sk";
            value = { };
          }) ifaces)
          {
            gh-runner-nix-config = { };
          }
        ];
      };
    };
}
