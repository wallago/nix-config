{
  lib,
  config,
  pkgs,
  inputs,
  outputs,
  ...
}:
let
  username = "yc";
in
{
  imports = [
    ./common.nix
    (import ../../common {
      inherit
        username
        lib
        config
        pkgs
        outputs
        # inputs
        ;
    })
    ../../feat/desktop
  ];

  # wallpaper = pkgs.inputs.themes.wallpapers.lake-houses-sunset-gold;
  wallpaper = inputs.themes.packages.${pkgs.system}.wallpapers.aenami-bright-planet;

}
