{ self, ... }:
{
  flake.nixosModules.ai = {
    imports = [
      self.nixosModules.claude
    ];
  };
}
