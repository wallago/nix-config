{
  flake.nixosModules.preferencesGithubRunnersCuttlefish =
    { config, ... }:
    {
      preferences.github.runners = {
        nix-config = {
          tokenFile = config.sops.secrets.gh-runner-nix-config.path;
          url = "https://github.com/wallago/nix-config";
        };
      };
    };
}
