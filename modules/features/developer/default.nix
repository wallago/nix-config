{ self, ... }:
{
  flake.homeModules.developer = {
    imports = [
      self.homeModules.git
      self.homeModules.jujutsu
    ];
  };
}
