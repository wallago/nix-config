{ self, ... }: {
  flake.nixosModules.secretsCoral = { config, ... }: {

    imports = [
      self.nixosModules.secretsSyncthing
      self.nixosModules.secretsMiniflux
      self.nixosModules.secretsWireguardServer
      self.nixosModules.secretsUser
      self.nixosModules.secretsAttic
      self.nixosModules.secretsClaude
    ];

    sops.secrets = {
      "wallago.xyz-ssl-key" = {
        owner = config.services.nginx.user;
        group = config.services.nginx.group;
      };
    };
  };
}
