{ inputs, self, ... }:
{
  flake.nixosModules.todo =
    { config, hostName, ... }:
    let
      cfg = config.preferences.todo;
      hostModule = self.nixosModules."preferencesTodo${self.lib.capitalize hostName}";
    in
    {
      imports = [
        inputs.todo.nixosModules.default
        self.nixosModules.todoOptions
        hostModule
      ];

      services.todo = {
        server = {
          enable = true;
          inherit (cfg) user group;
          inherit (cfg.server) tokenFile;
          settings = {
            server = { inherit (cfg.server) address port; };
            vault = {
              root = cfg.server.vault.rootPath;
              inbox = "todo.md";
            };
            mcp.allowedHosts = cfg.server.mcp.allowedHosts;
          };
        };
        inherit (cfg) firewallInterfaces;
      };
    };
}
