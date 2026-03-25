{
  lib,
  pkgs,
  config,
  ...
}:
let
  apps = {
    markeeper = {
      backup = true;
    };
    rewind = {
      backup = true;
    };
    atticd = {
      backup = false;
    };
  };
  appNames = builtins.attrNames apps;
  secretOf = name: config.sops.secrets."${name}-db-password".path;
  mkUser = name: {
    inherit name;
    ensureDBOwnership = true;
    ensureClauses = {
      superuser = false;
      createrole = true;
      createdb = true;
    };
  };
  mkCredLine = name: "${name}pass:${secretOf name}";
  mkAlterSql =
    name:
    ''${psql} -c "ALTER USER ${name} WITH ENCRYPTED PASSWORD '$(cat "$CREDENTIALS_DIRECTORY/${name}pass")';"'';
  psql = "${pkgs.postgresql}/bin/psql";
in
{
  services.postgresql = {
    enable = true;
    enableTCPIP = true;
    authentication = lib.mkOverride 10 ''
      #type  database  DBuser  origin-address  auth-method
      local  all       all                     trust
      host   all       all     127.0.0.1/32    md5
      host   all       all     ::1/128         md5
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
    ensureDatabases = appNames;
    ensureUsers = map mkUser appNames;
  };

  systemd.services.postgres-init-passwords = {
    description = "Set PostgreSQL passwords after database is ready";
    after = [ "postgresql.service" ];
    requires = [ "postgresql.service" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      User = "postgres";
      LoadCredential = [ "pgpass:${secretOf "postgres"}" ] ++ map mkCredLine appNames;
      ExecStart = pkgs.writeShellScript "set-postgres-passwords" ''
        ${psql} -c "ALTER USER postgres WITH ENCRYPTED PASSWORD '$(cat "$CREDENTIALS_DIRECTORY/pgpass")';"
        ${lib.concatMapStringsSep "\n" mkAlterSql appNames}
      '';
    };
  };

  sops.secrets =
    lib.genAttrs ([ "postgres-db-password" ] ++ map (n: "${n}-db-password") appNames)
      (_: {
        sopsFile = ../secrets.yaml;
        neededForUsers = true;
      });

  services.postgresqlBackup = {
    enable = true;
    compression = "zstd";
    databases = builtins.filter (n: apps.${n}.backup) appNames;
  };

  environment.persistence."/persist".directories = [
    "/var/lib/postgresql/"
    "/var/backup/postgresql/"
  ];
}
