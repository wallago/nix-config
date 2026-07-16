{ self, ... }: {
  flake.nixosModules.preferencesSyncthingSponge =
    { config, ... }:
    let
      hosts = self.lib.syncthing.hosts;
    in
    {
      preferences.syncthing = {
        cert = config.sops.secrets."syncthing-cert".path;
        key = config.sops.secrets."syncthing-key".path;
        guiPasswordFile = config.sops.secrets."syncthing-password".path;
        folders = {
          nvim = {
            name = "sync-nvim";
            devices = {
              inherit (hosts) coral squid;
            };
          };
          bagels = {
            name = "sync-bagels";
            devices = {
              inherit (hosts) coral squid;
            };
          };
          notes = {
            name = "sync-notes";
            devices = {
              inherit (hosts) coral squid worm;
            };
          };
        };
      };
    };
}
