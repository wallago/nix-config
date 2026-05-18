{
  flake.nixosModules.user =
    { config, ... }:
    let
      userName = config.preferences.user.name;
      authorizedSshKeys = config.preferences.user.authorizedSshKeys;
    in
    {
      users.users.${userName} = {
        isNormalUser = true;
        description = userName;
        openssh.authorizedKeys.keys = authorizedSshKeys;
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
