{
  flake.nixosModules.todoOptions =
    { lib, ... }:
    {
      options.preferences.todo = {
        user = lib.mkOption {
          type = lib.types.str;
          description = "User the server runs as. Needs write access to the vault.";
        };
        group = lib.mkOption {
          type = lib.types.str;
          description = "Group the server runs as.";
        };
        server = {
          tokenFile = lib.mkOption {
            type = lib.types.str;
            description = "Path to the file holding the bearer token (a sops secret).";
          };
          address = lib.mkOption {
            type = lib.types.str;
            description = "Server address.";
          };
          port = lib.mkOption {
            type = lib.types.port;
            description = "Server port.";
          };
          vault.rootPath = lib.mkOption {
            type = lib.types.str;
            description = "Vault root path, absolute.";
          };
          mcp.allowedHosts = lib.mkOption {
            type = lib.types.listOf lib.types.str;
            default = [
              "localhost"
              "127.0.0.1"
              "::1"
            ];
            description = "Host headers accepted on /mcp. Never [ ]: that accepts every host.";
          };
        };
        firewallInterfaces = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          default = [ ];
          description = "Open the port on these interfaces only.";
        };
      };
    };

  flake.homeModules.todoOptions =
    { lib, ... }:
    let
      char = lib.types.strMatching "." // {
        description = "single character";
      };
    in
    {
      options.preferences.todo = {
        server = {
          tokenFile = lib.mkOption {
            type = lib.types.str;
            description = "Path to the file holding the bearer token (a sops secret).";
          };
          url = lib.mkOption {
            type = lib.types.str;
            description = "Todo server url.";
          };
        };
        keys = {
          up = lib.mkOption {
            type = char;
            description = "Up key.";
          };
          down = lib.mkOption {
            type = char;
            description = "Down key.";
          };
          left = lib.mkOption {
            type = char;
            description = "Left key.";
          };
          right = lib.mkOption {
            type = char;
            description = "Right key.";
          };
        };
      };
    };
}
