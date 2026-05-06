{ self, ... }:
{
  flake.nixosModules.security = {
    imports = [
      self.nixosModules.fail2ban
      self.nixosModules.yubikey
    ];
  };
}
