{
  flake.nixosModules.secretsTodo = {
    sops.secrets = {
      todoToken = { };
    };
  };
}
