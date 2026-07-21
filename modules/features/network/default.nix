{ self, ... }:
{
  flake.nixosModules.networking =
    { hostName, ... }:
    {
      imports = [
        self.nixosModules.ssh
      ];

      networking = {
        networkmanager.enable = true;
        firewall.enable = true;
        inherit hostName;
      };
    };

  flake.homeModules.networking = {
    imports = [
      self.homeModules.ssh
    ];
  };
}
