{
  flake.nixosModules.secretsCoral =
    { config, lib, ... }:
    {
      sops.defaultSopsFile = ../../secrets/coral.yaml;

      sops.secrets = lib.mkMerge [
        {
          wallago-password.neededForUsers = true;
        }
      ];
    };
}
