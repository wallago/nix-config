{
  flake.nixosModules.preferencesGithubRunnersKrill =
    { config, ... }:
    let
      sops = config.sops.secrets;
    in
    {
      preferences.github.runners = {
        nix-config-1 = {
          tokenFile = sops.gh-runner-nix-config-1.path;
          url = "https://github.com/wallago/nix-config";
        };
        nix-config-2 = {
          tokenFile = sops.gh-runner-nix-config-2.path;
          url = "https://github.com/wallago/nix-config";
        };
      };
    };
}
