{ pkgs, inputs, config, ... }:
let
  rewind = {
    backend = "${
        inputs.rewind-backend.defaultPackage.${pkgs.system}
      }/bin/rewind-backend";
    frontend = "${inputs.rewind-frontend.packages.${pkgs.system}.default}";
  };
  rewind-db-passwd = config.sops.secrets.rewind-db-password.path;
  ssl-crt = config.sops.secrets."henrotte.work-ssl-crt".path;
  ssl-key = config.sops.secrets."henrotte.work-ssl-key".path;
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
      ];
      ExecStart = pkgs.writeShellScript "run-rewind-backend" ''
        export DATABASE_URL=postgres://rewind:$(cat $CREDENTIALS_DIRECTORY/rewindDbPass)@localhost:5432
        export APP_PORT=${toString server-port}
        export FRONTEND="${rewind.frontend}"
        export SSL_CRT=$CREDENTIALS_DIRECTORY/sslCrt
        export SSL_KEY=$CREDENTIALS_DIRECTORY/sslKey
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
  };
}
