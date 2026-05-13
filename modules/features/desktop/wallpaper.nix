{
  flake.homeModules.wallpaper =
    {
      lib,
      pkgs,
      config,
      ...
    }:
    {
      services.awww.enable = true;
      systemd.user.services.awww.Service.ExecStartPost = lib.mapAttrsToList (
        name: display: "${lib.getExe pkgs.awww} img -o ${name} ${display.wallpaper} -t none"
      ) (lib.filterAttrs (_: display: display.wallpaper != null) config.preferences.monitors);
    };
}
