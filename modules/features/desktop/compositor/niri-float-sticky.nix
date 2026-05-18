{ inputs, ... }:
{
  flake.homeModules.niriFloatSticky =
    { pkgs, lib, ... }:
    let
      niri-flaot-sticky = inputs.niri-float-sticky.packages.${pkgs.stdenv.hostPlatform.system}.default;
    in
    {
      home.packages = [
        niri-flaot-sticky
      ];

      systemd.user.services.niri-float-sticky-pip = {
        Unit = {
          Description = "Sticky floating windows for niri";
          PartOf = [ "graphical-session.target" ];
          After = [ "graphical-session.target" ];
        };
        Service = {
          ExecStart = "${lib.getExe niri-flaot-sticky} -app-id 'zen-beta' -title '^Picture-in-Picture$'";
          Restart = "on-failure";
        };
        Install.WantedBy = [ "graphical-session.target" ];
      };
    };
}
