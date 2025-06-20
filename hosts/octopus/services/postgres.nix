{ lib, ... }: {
  services.postgresql = {
    enable = true;
    enableTCPIP = true;
    #ensureDatabases = [ "mydatabase" ];
    #authentication = lib.mkOverride 10 ''
    #  #type database  DBuser  auth-method
    #  local all       all     trust
    #'';
    # settings = {
    #   listen_addresses = "*";
    #   log_connections = true;
    #   log_disconnections = true;
    #   log_destination = "stderr";
    #   logging_collector = true;
    #   log_directory = "log";
    #   log_filename = "postgresql-%a.log";
    #   log_statement = "mod";
    #   client_min_messages = "notice";
    # };
  };

  environment.persistence = {
    "/persist".directories = [ "/var/lib/postgresql" ];
  };

  networking.firewall.allowedTCPPorts = [ 5432 ];
}
