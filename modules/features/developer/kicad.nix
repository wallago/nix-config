{
  flake.nixosModules.kicad =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        kicad
      ];
    };
}
