{ self, ... }: {
  flake.nixosModules.secretsSquid = {
    imports = [
      self.nixosModules.secretsWireguardClient
      self.nixosModules.secretsUser
      self.nixosModules.secretsSyncthing
    ];
  };
}
