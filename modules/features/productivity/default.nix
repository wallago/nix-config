{ self, ... }:
{
  flake.homeModules.productivity = {
    imports = [
      self.homeModules.eilmeldung
    ];
  };
}
