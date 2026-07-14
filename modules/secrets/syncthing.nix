{
  flake.nixosModules.secretsSyncthing =
    { config, ... }:
    {
      sops.secrets = {
        syncthing-password.owner = config.services.syncthing.user;
        syncthing-cert = { };
        syncthing-key = { };
      };
    };
}
