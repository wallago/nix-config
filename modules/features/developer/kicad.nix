{
  flake.nixosModules.kicad =
    { pkgs, ... }:
    {
      environementPackages = with pkgs; [
        kicad
      ];
    };
}
