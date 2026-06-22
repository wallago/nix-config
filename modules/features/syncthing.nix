{ self, ... }: {
  flake.nixosModules.syncthing =
    {
      config,
      hostName,
      lib,
      ...
    }:
    let
      cfg = config.preferences.syncthing;
      defaultUser = config.preferences.user.name;
      hostModule = self.nixosModules."preferencesSyncthing${self.lib.capitalize hostName}";
      allDevices = lib.foldl' (acc: folder: acc // folder.devices) { } (lib.attrValues cfg.folders);
    in
    {
      imports = [
        self.nixosModules.syncthingOptions
        hostModule
      ];

      services.syncthing = {
        enable = true;
        user = defaultUser;
        group = "users";
        configDir = "/home/${defaultUser}/.config/syncthing";
        dataDir = "/home/${defaultUser}/.local/share/syncthing";

        inherit (cfg)
          cert
          key
          guiPasswordFile
          ;

        settings = {
          gui = {
            user = "admin";
            insecureSkipHostcheck = true;
          };
          devices = lib.mapAttrs (_: dev: { inherit (dev) id addresses; }) allDevices;
          folders = lib.mapAttrs (_: folder: {
            label = folder.name;
            path = "/home/${defaultUser}/${folder.name}";
            devices = lib.attrNames folder.devices;
          }) cfg.folders;
        };

        overrideDevices = true;
        overrideFolders = true;
      };

      networking.firewall.interfaces."wg0".allowedTCPPorts = [ 22000 ];
    };
}
