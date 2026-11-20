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
          readTokenFile = sops.todoReadToken.path;
          address = "0.0.0.0";
          port = 5505;
          publicUrl = "https://todo.wallago.xyz";
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
