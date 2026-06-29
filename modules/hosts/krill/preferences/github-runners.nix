{
  flake.nixosModules.preferencesGithubRunnersKrill =
    { config, pkgs, ... }:
    let
      sops = config.sops.secrets;
    in
    {
      preferences.github.runners = {
        nix-config-1 = {
          tokenFile = sops.gh-runner-nix-config-1.path;
          url = "https://github.com/wallago/nix-config";
          extraPackages = with pkgs; [
            wget
            curl
            lychee
          ];
        };
        nix-config-2 = {
          tokenFile = sops.gh-runner-nix-config-2.path;
          url = "https://github.com/wallago/nix-config";
          extraPackages = with pkgs; [
            wget
            curl
            lychee
          ];
        };
        bp-to-bagels-csv = {
          tokenFile = sops.gh-runner-bp-to-bagels-csv.path;
          url = "https://github.com/wallago/bp-to-bagels-csv";
          extraPackages = with pkgs; [
            wget
            curl
          ];
        };
      };
    };
}
