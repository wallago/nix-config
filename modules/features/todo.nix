{ inputs, ... }:
{
  flake.nixosModules.todo = {
    imports = [ inputs.todo.nixosModules.default ];

    services.todo = {
      server = {
        enable = true;
        user = "wallago";
        group = "users";
        settings = {
          server = {
            address = "0.0.0.0";
            port = 5505;
          };
          vault = {
            root = "/home/wallago/sync-todo";
            inbox = "todo.md";
          };
        };
      };
      # mcp = {
      #   enable = true;
      #   listen = "0.0.0.0:5506";
      #   # allowedHosts = [
      #   #   "homelab"
      #   #   "homelab.your-tailnet.ts.net"
      #   # ];
      # };
      firewallInterfaces = [ "wg0" ];
    };
  };
}
