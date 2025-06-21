{ lib, ... }: {
  services.postgresql = {
    enable = true;
    enableTCPIP = true;
    authentication = lib.mkOverride 10 ''
      #type database DBuser origin-address auth-method
      local all      all                   trust
      # ipv4
      # host  all      all    127.0.0.1/32   trust
      host  all      all    0.0.0.0/0      trust
      # ipv6
      # host  all      all    ::1/128        trust
      # host  all      all    ::/0           trust
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
    "/persist".directories = [ "/var/lib/postgresql" ];
  };

  networking.firewall.allowedTCPPorts = [ 5432 ];
}
