{ self, ... }:
{
  flake.nixosModules.desktop =
    { pkgs, ... }:
    {
      programs.niri = {
        enable = true;
        package = self.package.${pkgs.stdenv.hostPlatform.system}.myNiri;
      };
    };
}
