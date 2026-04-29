{
  flake.nixosModules.user =
    { config, ... }:
    let
      userName = config.preferences.user.name;
    in
    {
      users.users.${userName} = {
        isNormalUser = true;
        description = userName;
      };
    };

  flake.homeModules.user =
    { config, ... }:
    let
      userName = config.preferences.user.name;
    in
    {
      home = {
        username = userName;
        homeDirectory = "/home/${userName}";
      };
    };
}
