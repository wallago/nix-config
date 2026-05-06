{ self, ... }:
{
  flake.nixosModules.base = {
    imports = [
      self.nixosModules.optionUser
    ];
  };

  flake.homeModules.base = {
    imports = [
      self.homeModules.optionUser
      self.homeModules.optionDesktop
    ];
  };
}
