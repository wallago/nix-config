{
  flake.nixosModules.preferencesHeadscaleProvisionIso =
    { config, ... }:
    {
      preferences.headscale.client = {
        # Same name on every boot key; headscale adds a suffix to duplicates.
        hostName = "provision";
        authKeyFile = config.sops.secrets."headscale-provision-key".path;
      };

      # Output of `just ext-iso-key`, stored with `just secret provision-iso`.
      sops.secrets."headscale-provision-key".sopsFile = ../../../secrets/provision-iso.yaml;
    };
}
