{ config, ... }:
{
  services.couchdb = {
    enable = true;
    extraConfig = {
      couchdb = {
        single_node = true;
        max_document_size = 50000000;
      };
      chttpd = {
        require_valid_user = true;
        max_http_request_size = 4294967296;
        enable_cors = true;
      };
      chttpd_auth = {
        require_valid_user = true;
      };
      httpd = {
        WWW-Authenticate = "Basic realm=\"couchdb\"";
        enable_cors = true;
      };
      cors = {
        origins = "app://obsidian.md,capacitor://localhost,http://localhost";
        credentials = true;
        headers = "accept, authorization, content-type, origin, referer";
        methods = "GET, PUT, POST, HEAD, DELETE";
        max_age = 3600;
      };
    };
    extraConfigFiles = [
      config.sops.secrets."couch-db-admin".path
    ];
  };

  sops.secrets."couch-db-admin" = {
    sopsFile = ../secrets.yaml;
    owner = "couchdb";
    group = "couchdb";
  };
}
