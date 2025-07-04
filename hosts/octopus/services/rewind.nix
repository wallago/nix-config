{ pkgs, inputs, config, ... }:
let
  rewind.backend = "${
      inputs.rewind-backend.packages.${pkgs.system}.default
    }/bin/rewind-backend";
  rewind-passwd = config.sops.secrets.rewind-db-password.path;
in {
  systemd.services.rewind-backend = {
    description = "Run rewind backend";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      LoadCredential = [ "rewindpass:${rewind-passwd}" ];
      ExecStart = pkgs.writeShellScript "run-rewind-backend" ''
        /bin/sh -c "export DATABASE_URL=postgres://rewind:$(cat $CREDENTIALS_DIRECTORY/rewindpass)@localhost:5432 && ${rewind.backend}"
      '';
      EnvironmentVariables = [ "APP_PORT=8081" ];
      Restart = "on-failure";
    };
  };

  sops.secrets.rewind-db-password = {
    sopsFile = ../secrets.yaml;
    format = "yaml";
    neededForUsers = true;
  };
}
