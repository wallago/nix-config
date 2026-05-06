{ self, ... }:
{
  flake.nixosModules.desktop = {
    imports = [
      self.nixosModules.displayManager
      self.nixosModules.qylock
      self.nixosModules.fonts
      self.nixosModules.niri
    ];
  };

  flake.homeModules.desktop = {
    imports = [
      self.homeModules.ghostty
      self.homeModules.niri
      self.homeModules.noctalia
    ];
  };

}
