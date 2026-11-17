{
  flake.nixosModules.preferencesMindKrill =
    { config, ... }:
    let
      sops = config.sops.secrets;
    in
    {
      preferences.mind = {
        user = "wallago";
        group = "users";
        server = {
          tokenFile = sops.mindToken.path;
          address = "0.0.0.0";
          port = 5506;
          vault.rootPath = "/home/wallago/sync-mind";
          mcp.allowedHosts = [
            "mind.wallago.xyz"
            "127.0.0.1"
            "::1"
          ];
        };
        firewallInterfaces = [ "wg0" ];
      };
    };
}
