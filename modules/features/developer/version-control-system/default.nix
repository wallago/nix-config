{ self, ... }:
{
  flake.homeModules.versionControlManager = {
    imports = [
      self.homeModules.git
      self.homeModules.jujutsu
    ];
  };
}
