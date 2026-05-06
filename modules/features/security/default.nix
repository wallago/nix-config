{ self, ... }:
{
  flake.nixosModules.security = {
    imports = [
      self.nixosModules.fail2ban
    ];
  };
}
