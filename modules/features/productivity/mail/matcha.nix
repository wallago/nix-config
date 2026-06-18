{
  flake.homeModules.matcha =
    { config, pkgs, ... }:
    let
      sopsFile = ../../../secrets/productivity.yaml;
    in
    {
      sops = {
        secrets = {
          gmail-oauth2-client-secret = { inherit sopsFile; };
          gmail-oauth2-client-id = { inherit sopsFile; };
          outlook-oauth2-client-secret = { inherit sopsFile; };
          outlook-oauth2-client-id = { inherit sopsFile; };
        };
        # https://console.cloud.google.com
        templates."matcha-oauth_client_gmail.json" = {
          mode = "0600";
          content = builtins.toJSON {
            client_id = config.sops.placeholder."gmail-oauth2-client-id";
            client_secret = config.sops.placeholder."gmail-oauth2-client-secret";
          };
        };
        # https://portal.azure.com
        templates."matcha-oauth_client_outlook.json" = {
          mode = "0600";
          content = builtins.toJSON {
            client_id = config.sops.placeholder."outlook-oauth2-client-id";
            client_secret = config.sops.placeholder."outlook-oauth2-client-secret";
          };
        };
      };

      # To add a email (google): matcha gmail auth ...@gmail.com
      home.packages = with pkgs; [
        matcha
        python3 # deps
      ];

      xdg.configFile."matcha/oauth_client.json".source =
        config.lib.file.mkOutOfStoreSymlink
          config.sops.templates."matcha-oauth_client_gmail.json".path;

      xdg.configFile."matcha/oauth_client_outlook.json".source =
        config.lib.file.mkOutOfStoreSymlink
          config.sops.templates."matcha-oauth_client_outlook.json".path;

    };

}
