{ self, ... }:
{
  flake.homeModules.ai = {
    imports = [
      self.homeModules.claude
    ];
  };
}
