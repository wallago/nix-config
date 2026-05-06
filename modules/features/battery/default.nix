{ self, ... }:
{
  flake.nixosModules.battery = {
    imports = [
      self.nixosModules.upower
      self.nixosModules.tlp
    ];
  };
}
