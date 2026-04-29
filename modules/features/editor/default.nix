{ self, ... }:
{
  flake.nixosModules.editor = {
    imports = [
      self.nixosModules.helix
    ];
  };
}
