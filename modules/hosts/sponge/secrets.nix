{ self, ... }: {
  flake.nixosModules.secretsSponge = {
    imports = [
      self.nixosModules.secretsWireguardClient
      self.nixosModules.secretsUser
      self.nixosModules.secretsSyncthing
    ];
  };
}
