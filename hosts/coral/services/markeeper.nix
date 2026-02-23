{
  pkgs,
  inputs,
  config,
  ...
}:
let
  markeeper = {
    backend = "${inputs.markeeper-backend.packages.${pkgs.system}.default}/bin/markeeper-backend";
    frontend = "${inputs.markeeper-frontend.packages.${pkgs.system}.default}";
  };
  markeeper-db-passwd = config.sops.secrets.markeeper-db-password.path;
  server-port = 5501;
in
{
  systemd.services.markeeper = {
    description = "Run markeeper app";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      LoadCredential = [
        "markeeperDbPass:${markeeper-db-passwd}"
      ];
      ExecStart = pkgs.writeShellScript "run-markeeper-backend" ''
        export DATABASE_URL=postgres://markeeper:$(cat $CREDENTIALS_DIRECTORY/markeeperDbPass)@localhost:5432
        export APP_PORT=${toString server-port}
        export FRONTEND="${markeeper.frontend}"
        ${markeeper.backend}
      '';
      Restart = "on-failure";
    };
  };

  sops.secrets = {
    markeeper-db-password = {
      sopsFile = ../secrets.yaml;
      neededForUsers = true;
    };
  };
}
