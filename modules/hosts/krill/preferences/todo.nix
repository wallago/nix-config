{
  flake.nixosModules.preferencesTodoKrill =
    { config, ... }:
    let
      sops = config.sops.secrets;
    in
    {
      preferences.todo = {
        user = "wallago";
        group = "users";
        server = {
          tokenFile = sops.todoToken.path;
          address = "0.0.0.0";
          port = 5505;
          vault.rootPath = "/home/wallago/sync-todo";
          mcp.allowedHosts = [
            "todo.wallago.xyz"
            "127.0.0.1"
            "::1"
          ];
        };
        firewallInterfaces = [ "wg0" ];
      };
    };
}
