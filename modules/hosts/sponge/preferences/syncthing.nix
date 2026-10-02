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
          notes = {
            name = "sync-notes";
            devices = {
              inherit (hosts) coral squid worm;
            };
          };
          pm = {
            name = "sync-pm";
            devices = {
              inherit (hosts) coral squid worm;
            };
          };
          habit = {
            name = "sync-habit";
            devices = {
              inherit (hosts) coral squid;
            };
          };
          mind = {
            name = "sync-mind";
            devices = {
              inherit (hosts) coral squid worm;
            };
          };
        };
      };
    };
}
