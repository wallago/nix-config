{
  flake.nixosModules.vmNix =
    {
      lib,
      config,
      pkgs,
      ...
    }:
    let
      userName = config.preferences.user.name;
    in
    {
      environment.systemPackages = with pkgs; [ qemu ];

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
