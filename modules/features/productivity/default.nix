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
      self.homeModules.sprout # habbits
      self.homeModules.khal # calendar
    ];

  };
}
