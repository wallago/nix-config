{ inputs, ... }:
{
  # The host brings its own layout, e.g.
  # imports = [ self.diskoConfigurations.hostCoral ];
  # so hosts from other flakes can use this module too.
  flake.nixosModules.disko = {
    imports = [ inputs.disko.nixosModules.disko ];

    fileSystems."/persist".neededForBoot = true;
    fileSystems."/home".neededForBoot = true;
  };
}
