{
  flake.nixosModules.probe-rs =
    {
      pkgs,
      ...
    }:
    {
      environment.systemPackages = [ pkgs.probe-rs-tools ];
      services.udev.packages = [ pkgs.probe-rs-tools ];
    };
}
