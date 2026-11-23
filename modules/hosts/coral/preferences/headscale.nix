{
  flake.nixosModules.preferencesHeadscaleCoral =
    { config, ... }:
    {
      preferences.headscale.server.port = 5507;

      # vpn.wallago.xyz is DNS only (tailscale clients connect straight to
      # coral), so it needs a publicly trusted cert. DNS-01 through the
      # Cloudflare API works without opening port 80.
      security.acme = {
        acceptTerms = true;
        certs."vpn.wallago.xyz" = {
          dnsProvider = "cloudflare";
          # Holds `CF_DNS_API_TOKEN=<token>` (Zone → DNS → Edit on wallago.xyz).
          environmentFile = config.sops.secrets."cloudflare-dns-token".path;
          group = "nginx";
        };
      };

      sops.secrets."cloudflare-dns-token".sopsFile = ../../../secrets/coral.yaml;

      # Keep issued certs across reboots, or every boot re-orders one.
      environment.persistence."/persist".directories = [ "/var/lib/acme" ];
    };
}
