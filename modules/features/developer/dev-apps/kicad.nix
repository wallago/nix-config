{
  flake.nixosModules.kicad =
    { pkgs, ... }:
    {
      environment.systemPackages = [
        (pkgs.symlinkJoin {
          name = "kicad-x11";
          paths = [ pkgs.kicad ];
          nativeBuildInputs = [ pkgs.makeWrapper ];
          postBuild = ''
            for bin in $out/bin/*; do
              wrapProgram "$bin" --set GDK_BACKEND x11
            done
          '';
        })
      ];
    };
}
