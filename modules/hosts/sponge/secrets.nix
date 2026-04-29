{
  flake.nixosModules.secretsSponge = {
    sops.defaultSopsFile = ../../secrets/sponge.yaml;
    sops.secrets.wallago-password = {
      sopsFile = ../../secrets/sponge.yaml;
      neededForUsers = true;
    };
  };
}
