{
  flake.nixosModules.secretsTodoServer = {
    sops.secrets = {
      todoToken = { };
      todoReadToken = { };
    };
  };
  flake.nixosModules.secretsTodoTui = {
    sops.secrets = {
      todoToken = { };
    };
  };
}
