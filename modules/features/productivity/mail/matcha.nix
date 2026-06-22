{
  flake.nixosModules.matcha =
    { config, ... }:
    let
      sopsFile = ../../../secrets/productivity.yaml;
    in
    {
      sops = {
        secrets = {
          gmail-oauth2-client-secret = { inherit sopsFile; };
          gmail-oauth2-client-id = { inherit sopsFile; };
        };
        # https://console.cloud.google.com
        templates."matcha-oauth_client_gmail.json" = {
          owner = config.preferences.user.name;
          mode = "0600";
          content = builtins.toJSON {
            client_id = config.sops.placeholder."gmail-oauth2-client-id";
            client_secret = config.sops.placeholder."gmail-oauth2-client-secret";
          };
        };
      };
    };

  flake.homeModules.matcha = { config, pkgs, ... }: {
    # To add a email (google): matcha gmail auth ...@gmail.com
    home.packages = with pkgs; [
      matcha
      python3 # deps
    ];

    xdg.configFile."matcha/oauth_client.json".source =
      config.lib.file.mkOutOfStoreSymlink "/run/secrets/rendered/matcha-oauth_client_gmail.json";
  };
}
