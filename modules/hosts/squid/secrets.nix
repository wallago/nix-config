{
  flake.nixosModules.secretsSquid = {
    sops.defaultSopsFile = ../../secrets/squid.yaml;
    sops.secrets.wallago-password = {
      sopsFile = ../../secrets/squid.yaml;
      neededForUsers = true;
    };
  };
}
