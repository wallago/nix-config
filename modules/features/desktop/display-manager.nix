{ self, ... }:
{
  flake.nixosModules.displayManager =
    { pkgs, ... }:
    {
      imports = [
        self.nixosModules.sddm
      ];

      environment.systemPackages = [ pkgs.xwayland-satellite ];
    };
}
