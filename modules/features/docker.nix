{
  flake.nixosModules.docker =
    {
      config,
      ...
    }:
    let
      userName = config.preferences.user.name;
    in
    {
      virtualisation.docker.enable = true;
      users.users."${userName}".extraGroups = [ "docker" ];
    };
}
