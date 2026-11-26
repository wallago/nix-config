{
  flake.nixosModules.secretsClaude = {
    sops.secrets = {
      anthropic-api-key = { };
    };
  };
}
