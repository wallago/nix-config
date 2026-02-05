{ inputs, pkgs, ... }:
let
  gateway = "${inputs.gateway.packages.${pkgs.system}.default}/bin/gateway";
in
{
  systemd.services.gateway = {
    description = "Run gateway";
    after = [
      "network.target"
    ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "${gateway}";
      Environment = [
        "RUST_LOG=info"
        ''APP_HOST="0.0.0.0"''
        "APP_PORT=3000"
      ];
      Restart = "on-failure";
    };
  };

  networking.firewall.allowedTCPPorts = [ 3000 ];
}
