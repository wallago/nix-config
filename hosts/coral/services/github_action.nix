{ config, ... }:
let github-runner-rewind = config.sops.secrets."github-runner-rewind".path;
in {
  services.github-runners = {
    rewind = {
      enable = true;
      name = "rewind";
      tokenFile = github-runner-rewind;
      url = "https://github.com/wallago/rewind";
    };
  };

  sops.secrets = {
    "github-runner-rewind" = {
      sopsFile = ../secrets.yaml;
      format = "yaml";
      neededForUsers = true;
    };
  };
}
