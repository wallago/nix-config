{ self, ... }: {
  flake.nixosModules.secretsAnemone = {
    imports = [
      self.nixosModules.secretsWireguardClient
      self.nixosModules.secretsUser
    ];
  };
}
