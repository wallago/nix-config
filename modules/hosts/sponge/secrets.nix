{ self, ... }: {
  flake.nixosModules.secretsSponge = { config, ... }: {
    imports = [
      self.nixosModules.secretsWireguardClient
      self.nixosModules.secretsUser
      self.nixosModules.secretsSyncthing
      self.nixosModules.secretsTodoTui
    ];

    sops.secrets.todoToken.owner = config.preferences.user.name;
  };
}
