{ pkgs, inputs, config, ... }:
let
  rewind = {
    backend = "${
        inputs.rewind-backend.defaultPackage.${pkgs.system}
      }/bin/rewind-backend";
    frontend = "${inputs.rewind-frontend.defaultPackage.${pkgs.system}}";
  };
  rewind-db-passwd = config.sops.secrets.rewind-db-password.path;
  ssl-crt = config.sops.secrets."henrotte.work-ssl-crt".path;
  ssl-key = config.sops.secrets."henrotte.work-ssl-key".path;
  github-client-ID = config.sops.secrets."github-client-ID".path;
  github-client-secret = config.sops.secrets."github-client-secret".path;
  server-port = 443;
in {
  systemd.services.rewind = {
    description = "Run rewind app";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      LoadCredential = [
        "rewindDbPass:${rewind-db-passwd}"
        "sslCrt:${ssl-crt}"
        "sslKey:${ssl-key}"
        "githubClientID:${github-client-ID}"
        "githubClientSecret:${github-client-secret}"
      ];
      ExecStart = pkgs.writeShellScript "run-rewind-backend" ''
        export GITHUB_CLIENT_ID=$(cat $CREDENTIALS_DIRECTORY/githubClientID)
        export GITHUB_CLIENT_SECRET=$(cat $CREDENTIALS_DIRECTORY/githubClientSecret)
        export DATABASE_URL=postgres://rewind:$(cat $CREDENTIALS_DIRECTORY/rewindDbPass)@localhost:5432
        export APP_PORT=${toString server-port}
        export FRONTEND="${rewind.frontend}"
        export SSL_CRT=$CREDENTIALS_DIRECTORY/sslCrt
        export SSL_KEY=$CREDENTIALS_DIRECTORY/sslKey
        export MODE=PROD
        ${rewind.backend}
      '';
      Restart = "on-failure";
    };
  };

  networking.firewall.allowedTCPPorts = [ server-port ];

  sops.secrets = {
    rewind-db-password = {
      sopsFile = ../secrets.yaml;
      format = "yaml";
      neededForUsers = true;
    };
    "henrotte.work-ssl-crt" = {
      sopsFile = ../secrets.yaml;
      format = "yaml";
      neededForUsers = true;
    };
    "henrotte.work-ssl-key" = {
      sopsFile = ../secrets.yaml;
      format = "yaml";
      neededForUsers = true;
    };
    "github-client-ID" = {
      sopsFile = ../secrets.yaml;
      format = "yaml";
      neededForUsers = true;
    };
    "github-client-secret" = {
      sopsFile = ../secrets.yaml;
      format = "yaml";
      neededForUsers = true;
    };
  };
}
