{
  flake.nixosModules.vmNix =
    { lib, config, ... }:
    let
      userName = config.preferences.user.name;
    in
    {
      virtualisation.vmVariant = {
        # Disable impermanence
        environment.persistence = lib.mkForce { };

        # No real disk
        disko.enableConfig = false;

        users = {
          mutableUsers = false;
          users.${userName} = {
            hashedPasswordFile = lib.mkForce null;
            password = lib.mkForce "vm";
          };
        };
      };
    };
}
