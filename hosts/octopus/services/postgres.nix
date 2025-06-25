{ lib, pkgs, config, ... }: {
  services.postgresql = {
    enable = true;
    enableTCPIP = true;
    authentication = lib.mkOverride 10 ''
      #type  database  DBuser  origin-address  auth-method
      local  all       all                     trust
      host   all       all     127.0.0.1/32    md5 
      host   all       all     ::1/128         md5
      host   rewind    rewind  0.0.0.0/0       md5
      host   rewind    rewind  ::/0            md5
    '';
    initialScript = pkgs.writeText "backend-initScript" ''
      alter user postgres with password '${config.sops.secrets.postgres-db-password.path}';
      alter user rewind with password '${config.sops.secrets.rewind-db-password.path}';
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
    ensureDatabases = [ "rewind" ];
    ensureUsers = [{
      name = "rewind";
      ensureDBOwnership = true;
      ensureClauses = {
        superuser = false;
        createrole = true;
        createdb = true;
      };
    }];
  };

  environment.persistence = {
    "/persist".directories =
      [ "/var/lib/postgresql/" "/var/backup/postgresql/" ];
  };

  networking.firewall.allowedTCPPorts = [ 5432 ];

  services.postgresqlBackup = {
    enable = true;
    compression = "zstd";
    databases = [ "rewind" ];
  };

  sops.secrets = {
    postgres-db-password = {
      sopsFile = ../secrets.yaml;
      format = "yaml";
      # Make this secret available early enough during system boot
      neededForUsers = true;
    };
    rewind-db-password = {
      sopsFile = ../secrets.yaml;
      format = "yaml";
      # Make this secret available early enough during system boot
      neededForUsers = true;
    };
  };
}
