{ self, ... }:
let
  inherit (self.lib) headscale;
in
{
  flake.nixosModules.headscaleServer =
    {
      config,
      lib,
      pkgs,
      hostName,
      ...
    }:
    let
      cfg = config.preferences.headscale.server;
      hostModule = self.nixosModules."preferencesHeadscale${self.lib.capitalize hostName}";
      admin = "${headscale.user}@";
      ports = lib.concatMapStringsSep "," toString;

      policy = {
        tagOwners = {
          "tag:griffon" = [ admin ];
          "tag:provision" = [ admin ];
        };
        # Only admins initiate. Nothing allows tag:griffon or tag:provision
        # as a source, so clients can't reach admins or each other.
        acls = [
          {
            action = "accept";
            src = [ admin ];
            dst = [ "tag:griffon:${ports headscale.clientPorts}" ];
          }
          {
            action = "accept";
            src = [ admin ];
            dst = [ "tag:provision:${ports headscale.provisionPorts}" ];
          }
        ];
      };

      # Mint pre-auth keys without remembering headscale's flags.
      keyTool = pkgs.writeShellApplication {
        name = "griffon-key";
        runtimeInputs = [
          config.services.headscale.package
          pkgs.jq
        ];
        text = ''
          # Usage: griffon-key provision | griffon-key client
          user_id="$(headscale users list -o json | jq -r '.[] | select(.name == "${headscale.user}") | .id')"
          if [ -z "$user_id" ]; then
            echo "no headscale user '${headscale.user}': run 'headscale users create ${headscale.user}'" >&2
            exit 1
          fi

          case "''${1:-}" in
            provision)
              # Shared by every boot key: reusable, and nodes vanish when the ISO powers off.
              headscale preauthkeys create --user "$user_id" --tags tag:provision \
                --reusable --ephemeral --expiration 90d
              ;;
            client)
              # One machine, used once at install.
              headscale preauthkeys create --user "$user_id" --tags tag:griffon \
                --expiration 2h
              ;;
            *)
              echo "usage: griffon-key provision | griffon-key client" >&2
              exit 1
              ;;
          esac
        '';
      };
    in
    {
      imports = [
        self.nixosModules.headscaleServerOptions
        hostModule
      ];

      services.headscale = {
        enable = true;
        address = "127.0.0.1";
        inherit (cfg) port;
        settings = {
          server_url = "https://${headscale.url}";
          dns = {
            magic_dns = true;
            base_domain = headscale.baseDomain;
            # Leave the car PCs' own DNS alone; only *.griffon.internal goes to MagicDNS.
            override_local_dns = false;
          };
          policy = {
            mode = "file";
            path = pkgs.writeText "headscale-policy.json" (builtins.toJSON policy);
          };
        };
      };

      environment.systemPackages = [ keyTool ];

      environment.persistence."/persist".directories = [
        {
          directory = "/var/lib/headscale";
          user = "headscale";
          group = "headscale";
          mode = "0750";
        }
      ];
    };

  flake.nixosModules.headscaleClient =
    {
      config,
      lib,
      options,
      hostName,
      ...
    }:
    let
      cfg = config.preferences.headscale.client;
      hostModule = self.nixosModules."preferencesHeadscale${self.lib.capitalize hostName}";
    in
    {
      imports = [
        self.nixosModules.headscaleClientOptions
        hostModule
      ];

      config = lib.mkMerge [
        {
          services.tailscale = {
            enable = true;
            openFirewall = true;
            inherit (cfg) authKeyFile;
            extraUpFlags = [
              "--login-server=https://${headscale.url}"
            ]
            ++ lib.optional (cfg.hostName != null) "--hostname=${cfg.hostName}";
          };
        }

        # Keep the node identity across reboots on impermanent hosts.
        (lib.optionalAttrs (options.environment ? persistence) {
          environment.persistence."/persist".directories = [ "/var/lib/tailscale" ];
        })
      ];
    };
}
