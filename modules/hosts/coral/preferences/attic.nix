{
  flake.nixosModules.preferencesAtticCoral =
    { config, ... }:
    {
      preferences.attic = {
        port = 5504;
        environmentFile = config.sops.secrets."atticd-env-keys".path;
      };
    };
}
