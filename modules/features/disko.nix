{ inputs, self, ... }:
{
  flake.nixosModules.disko = { hostName, ... }: {
    imports = [
      inputs.disko.nixosModules.disko
      self.diskoConfigurations."host${self.lib.capitalize hostName}"
    ];

    fileSystems."/persist".neededForBoot = true;
    fileSystems."/home".neededForBoot = true;
  };
}
