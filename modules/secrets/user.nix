{
  flake.nixosModules.secretsUser =
    { config, ... }:
    let
      userName = config.preferences.user.name;
    in
    {
      sops.secrets = {
        "${userName}-password".neededForUsers = true;
      };
    };
}
