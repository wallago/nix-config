{ self, ... }:
{
  flake.nixosModules.networking =
    { config, ... }:
    {
      imports = [
        self.nixosModules.ssh
      ];

      networking = {
        networkmanager.enable = true;
        firewall.enable = true;
        hostName = config.preferences.host.name;
      };
    };

  flake.homeModules.networking = {
    imports = [
      self.homeModules.ssh
    ];
  };
}
