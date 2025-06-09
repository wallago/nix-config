{ lib, ... }: {
  options.wallpaper = lib.mkOption {
    type = lib.types.str;
    default = "default";
    description = ''
      Wallpaper path
    '';
  };
}
