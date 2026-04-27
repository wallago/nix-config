{ config, pkgs, ... }:
let
  github-runner-rewind = config.sops.secrets."github-runner-rewind".path;
  github-runner-zmk = config.sops.secrets."github-runner-zmk".path;
in
{
  services.github-runners = {
    zmk = {
      enable = true;
      name = "zmk";
      tokenFile = github-runner-zmk;
      url = "https://github.com/wallago/zmk-config";
    };
    rewind = {
      enable = true;
      name = "rewind";
      tokenFile = github-runner-rewind;
      url = "https://github.com/wallago/rewind";
      extraPackages = [
        pkgs.docker
        pkgs.postgresql
      ];
      serviceOverrides = {
        DynamicUser = false;
      };
    };
  };

  sops.secrets = {
    "github-runner-rewind" = {
      sopsFile = ../secrets.yaml;
      neededForUsers = true;
    };
  };
  sops.secrets = {
    "github-runner-zmk" = {
      sopsFile = ../secrets.yaml;
      neededForUsers = true;
    };
  };
}
