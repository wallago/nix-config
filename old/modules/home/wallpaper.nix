{ lib, pkgs, ... }: {
  options.wallpaper = lib.mkOption {
    type = lib.types.path;
    default = pkgs.inputs.themes.wallpapers.default;
    description = ''
      Wallpaper path
    '';
  };
}
