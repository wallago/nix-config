{ self, ... }:
{
  flake.nixosModules.nixosOptions = {
    imports = [
      self.nixosModules.userOptions
    ];
  };

  flake.homeModules.homeOptions = {
    imports = [
      self.homeModules.userOptions
    ];
  };
}
