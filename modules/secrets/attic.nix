{
  flake.nixosModules.secretsAttic = {
    sops.secrets = {
      atticd-env-keys = { };
    };
  };
}
