{
  flake.nixosModules.secretsClaude = {
    sops.secrets = {
      claude-api-key = { };
    };
  };
}
