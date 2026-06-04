{
  flake.nixosModules.secretsCoral =
    { config, lib, ... }:
    let
      ifaces = config.preferences.wireguard.server.interfaces;
    in
    {
      sops.secrets = lib.mkMerge [
        {
          wallago-password.neededForUsers = true;
        }
        (lib.mapAttrs' (name: _: {
          name = "${name}-sk";
          value = { };
        }) ifaces)
        {
          miniflux-credentials = { };
          "wallago.xyz-ssl-crt" = {
            owner = config.services.nginx.user;
            group = config.services.nginx.group;
          };
          "wallago.xyz-ssl-key" = {
            owner = config.services.nginx.user;
            group = config.services.nginx.group;
          };
          atticd-env-keys = { };
          gh-runner-nix-config = { };
        }
      ];
    };
}
