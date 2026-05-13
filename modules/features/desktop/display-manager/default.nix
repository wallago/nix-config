{ self, ... }:
{
  flake.nixosModules.displayManager =
    { pkgs, ... }:
    {
      imports = [
        self.nixosModules.sddm
        self.nixosModules.qylock
      ];

      environment.systemPackages = [ pkgs.xwayland-satellite ];
    };
}
