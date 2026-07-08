{
  flake.nixosModules.fileSystemsCommon = {
    fileSystems."/persist".neededForBoot = true;
    fileSystems."/home".neededForBoot = true;
  };
}
