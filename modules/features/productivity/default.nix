{ self, ... }:
{
  flake.nixosModules.productivity = {
    imports = [
      self.nixosModules.matcha
    ];
  };

  flake.homeModules.productivity = {
    imports = [
      # self.homeModules.eilmeldung
      # self.homeModules.bagels
      self.homeModules.matcha # mails
      self.homeModules.sprout # habits
      self.homeModules.khal # calendar
    ];

  };
}
