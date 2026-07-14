{ self, ... }: {
  flake.nixosModules.secretsCuttlefish = {
    imports = [
      self.nixosModules.secretsWireguardClient
      self.nixosModules.secretsUser
    ];
  };
}
