{ ... }:
{
  users.mutableUsers = false;

  home-manager = {
    useGlobalPkgs = true;
    extraSpecialArgs = {
      inherit inputs outputs;
    };
  };

}
