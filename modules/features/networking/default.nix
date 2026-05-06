{ self, ... }:
{
  flake.nixosModules.networking = {
    imports = [
      self.nixosModules.ssh
    ];

    networking = {
      networkmanager.enable = true;
      firewall.enable = true;
    };
  };

  flake.homeModules.networking = {
    imports = [
      self.homeModules.ssh
    ];
  };
}
