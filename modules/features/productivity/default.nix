{ self, ... }:
{
  flake.nixosModules.productivity = {
    imports = [
      self.nixosModules.eilmeldung
    ];
  };

  flake.homeModules.productivity = {
    imports = [
      self.homeModules.eilmeldung
      self.homeModules.matcha
      self.homeModules.bagels
    ];
  };
}
