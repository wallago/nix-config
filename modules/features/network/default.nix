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
        hosts = {
          "10.100.0.1" = [
            "atuin.wallago.xyz"
            "sync.wallago.xyz"
            "cache.wallago.xyz"
          ];
        };
      };
    };

  flake.homeModules.networking = {
    imports = [
      self.homeModules.ssh
    ];
  };
}
