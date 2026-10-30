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
        inputs.todo.nixosModules.server
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

  flake.homeModules.todo =
    { config, hostName, ... }:
    let
      cfg = config.preferences.todo;
      hostModule = self.homeModules."preferencesTodo${self.lib.capitalize hostName}";
    in
    {
      imports = [
        inputs.todo.homeModules.tui
        self.homeModules.todoOptions
        hostModule
      ];

      programs.todo = {
        enable = true;
        settings = {
          inherit (cfg) server keys;
        };
      };
    };
}
