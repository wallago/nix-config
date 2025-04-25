{ lib, ... }: {
  options.wallpaper = lib.mkOption {
    type = lib.types.nullOr lib.types.path;
    default = null;
    description = ''
      Wallpaper path
    '';
  };
}
