{ pkgs, inputs, config, ... }:
let
  markeeper = {
    backend = "${
        inputs.markeeper-backend.packages.${pkgs.system}.default
      }/bin/markeeper-backend";
    frontend = "${inputs.markeeper-frontend.packages.${pkgs.system}.default}";
  };
  markeeper-db-passwd = config.sops.secrets.markeeper-db-password.path;
  ssl-crt = config.sops.secrets."henrotte.work-ssl-crt".path;
  ssl-key = config.sops.secrets."henrotte.work-ssl-key".path;
  server-port = 8443;
in {
  systemd.services.markeeper = {
    description = "Run markeeper app";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      LoadCredential = [
        "markeeperDbPass:${markeeper-db-passwd}"
        "sslCrt:${ssl-crt}"
        "sslKey:${ssl-key}"
      ];
      ExecStart = pkgs.writeShellScript "run-markeeper-backend" ''
        export DATABASE_URL=postgres://markeeper:$(cat $CREDENTIALS_DIRECTORY/markeeperDbPass)@localhost:5432
        export APP_PORT=${toString server-port}
        export FRONTEND="${markeeper.frontend}"
        export SSL_CRT=$CREDENTIALS_DIRECTORY/sslCrt
        export SSL_KEY=$CREDENTIALS_DIRECTORY/sslKey
        ${markeeper.backend}
      '';
      Restart = "on-failure";
    };
  };

  networking.firewall.allowedTCPPorts = [ server-port ];

  sops.secrets = {
    markeeper-db-password = {
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
  };
}
