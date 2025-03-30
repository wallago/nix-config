{ pkgs, ... }:
{
  users = {
    mutableUsers = false;
  };

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;

  };
}
