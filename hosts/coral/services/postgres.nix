{
  lib,
  pkgs,
  config,
  ...
}:
let
  postgres-passwd = config.sops.secrets.postgres-db-password.path;
  rewind-passwd = config.sops.secrets.rewind-db-password.path;
  markeeper-passwd = config.sops.secrets.markeeper-db-password.path;
  psql = "${pkgs.postgresql}/bin/psql";
  user = name: {
    name = name;
    ensureDBOwnership = true;
    ensureClauses = {
      superuser = false;
      createrole = true;
      createdb = true;
    };
  };
in
{
  services.postgresql = {
    enable = true;
    enableTCPIP = true;
    authentication = lib.mkOverride 10 ''
      #type  database     DBuser     origin-address  auth-method
      local  all          all                        trust
      host   all          all        127.0.0.1/32    md5
      host   all          all        ::1/128         md5
    '';
    settings = {
      log_connections = true;
      log_disconnections = true;
      log_destination = "stderr";
      logging_collector = true;
      log_directory = "log";
      log_filename = "postgresql-%a.log";
      log_statement = "mod";
      client_min_messages = "notice";
    };
    ensureDatabases = [
      "markeeper"
      "rewind"
    ];
    ensureUsers = [
      (user "markeeper")
      (user "rewind")
    ];
  };

  systemd.services.postgres-init-passwords = {
    description = "Set PostgreSQL passwords after database is ready";
    after = [ "postgresql.service" ];
    requires = [ "postgresql.service" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      User = "postgres";
      LoadCredential = [
        "pgpass:${postgres-passwd}"
        "markeeperpass:${markeeper-passwd}"
        "pgpass:${postgres-passwd}"
        "rewindpass:${rewind-passwd}"
      ];
      ExecStart = pkgs.writeShellScript "set-postgres-passwords" ''
        ${psql} -c "ALTER USER postgres WITH ENCRYPTED PASSWORD '$(cat "$CREDENTIALS_DIRECTORY/pgpass")';"
        ${psql} -c "ALTER USER markeeper WITH ENCRYPTED PASSWORD '$(cat "$CREDENTIALS_DIRECTORY/markeeperpass")';"
        ${psql} -c "ALTER USER rewind WITH ENCRYPTED PASSWORD '$(cat "$CREDENTIALS_DIRECTORY/rewindpass")';"
      '';
    };
  };

  environment.persistence = {
    "/persist".directories = [
      "/var/lib/postgresql/"
      "/var/backup/postgresql/"
    ];
  };

  networking.firewall.allowedTCPPorts = [ 5432 ];

  services.postgresqlBackup = {
    enable = true;
    compression = "zstd";
    databases = [
      "markeeper"
      "rewind"
    ];
  };

  sops.secrets = {
    postgres-db-password = {
      sopsFile = ../secrets.yaml;
      neededForUsers = true;
    };
    rewind-db-password = {
      sopsFile = ../secrets.yaml;
      neededForUsers = true;
    };
    markeeper-db-password = {
      sopsFile = ../secrets.yaml;
      neededForUsers = true;
    };
  };
}
