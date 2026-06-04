{
  flake.nixosModules.preferencesGithubRunnersKrill =
    { config, pkgs, ... }:
    {
      preferences.github.runners = {
        nix-config = {
          tokenFile = config.sops.secrets.gh-runner-nix-config.path;
          url = "https://github.com/wallago/nix-config";
          extraPackages = with pkgs; [
            bash
            curl
            git
            gnutar
            gzip
            coreutils
            gawk
            gnused
          ];
        };
      };
    };
}
