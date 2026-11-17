{ inputs, self, ... }:
{
  flake.nixosModules.mind =
    { config, hostName, ... }:
    let
      cfg = config.preferences.mind;
      hostModule = self.nixosModules."preferencesMind${self.lib.capitalize hostName}";
    in
    {
      imports = [
        inputs.mind.nixosModules.default
        self.nixosModules.mindOptions
        hostModule
      ];

      services.mind = {
        enable = true;
        inherit (cfg) user group;
        inherit (cfg.server) tokenFile;
        settings = {
          server = { inherit (cfg.server) address port; };
          vault.root = cfg.server.vault.rootPath;
          mcp.allowedHosts = cfg.server.mcp.allowedHosts;
        };
        inherit (cfg) firewallInterfaces;
      };
    };
}
