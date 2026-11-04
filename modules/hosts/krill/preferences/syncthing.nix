{ self, ... }: {
  flake.nixosModules.preferencesSyncthingKrill =
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
          todo = {
            name = "sync-todo";
            devices = {
              inherit (hosts)
                coral
                squid
                sponge
                worm
                krill
                ;
            };
          };
        };
      };
    };
}
