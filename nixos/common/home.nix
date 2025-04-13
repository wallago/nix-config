{ inputs, outputs, ... }:
{
  users.mutableUsers = false;

  home-manager = {
    backupFileExtension = "backup";
    useGlobalPkgs = true;
    extraSpecialArgs = {
      inherit inputs outputs;
    };
  };

}
