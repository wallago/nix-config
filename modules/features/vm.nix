{
  flake.nixosModules.vmNix =
    { lib, config, ... }:
    {
      virtualisation.vmVariant = {
        # No real disk
        disko.enableConfig = false;

        # Autologin the real user with a known throwaway password
        services.getty.autologinUser = config.preferences.user.name;
        users = {
          mutableUsers = false;
          users.${config.preferences.user.name} = {
            hashedPasswordFile = lib.mkForce null;
            password = lib.mkForce "vm";
          };
        };
      };
    };
}
