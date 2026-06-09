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
          folders = {
            "Notes" = {
              path = "/home/${defaultUser}/Notes";
              devices = lib.mapAttrsToList (name: _: name) cfg.devices;
            };
          };
          inherit (cfg)
            devices
            ;
        };

        overrideDevices = true;
        overrideFolders = true;
      };

      networking.firewall.interfaces."wg0".allowedTCPPorts = [ 22000 ];
    };
}
