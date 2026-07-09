{ self, ... }: {
  flake.nixosModules.secretsProvisionIso = {
    imports = [
      self.nixosModules.secretsWireguardClient
      self.nixosModules.secretsUser
    ];
  };
}
