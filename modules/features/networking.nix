{ self, ... }:
{
  flake.nixosModules.networking = {
    imports = [
      self.nixosModules.fail2ban
    ];

    networking = {
      networkmanager.enable = true;
      firewall.enable = true;
    };
  };
}
