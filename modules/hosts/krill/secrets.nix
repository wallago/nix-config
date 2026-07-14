{ self, ... }: {
  flake.nixosModules.secretsKrill = {
    imports = [
      self.nixosModules.secretsWireguardClient
      self.nixosModules.secretsUser
    ];

    sops = {
      secrets = {
        gh-runner-nix-config-1 = { };
        gh-runner-nix-config-2 = { };
        gh-runner-bp-to-bagels-csv = { };
      };
    };
  };
}
