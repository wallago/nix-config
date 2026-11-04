{
  flake.homeModules.wallpaper =
    {
      lib,
      pkgs,
      config,
      ...
    }:
    let
      awww = lib.getExe pkgs.awww;
      monitors = lib.filterAttrs (_: m: m.wallpaper != null) config.preferences.monitors;
    in
    {
      services.awww.enable = true;

      # Runs once the daemon answers. Each output is its own command, and the
      # leading `-` lets an unplugged screen fail without skipping the rest.
      systemd.user.services.awww-wallpaper = {
        Unit = {
          Description = "Set per-output wallpapers with awww";
          After = [ "awww.service" ];
          BindsTo = [ "awww.service" ];
          PartOf = [ "awww.service" ];
        };
        Service = {
          Type = "oneshot";
          TimeoutStartSec = 15;
          ExecStartPre = "${pkgs.bash}/bin/sh -c 'until ${awww} query >/dev/null 2>&1; do sleep 0.2; done'";
          ExecStart = lib.mapAttrsToList (
            name: m: "-${awww} img --outputs ${name} --resize crop --transition-type none ${m.wallpaper}"
          ) monitors;
        };
        Install.WantedBy = [ "awww.service" ];
      };
    };
}
