{
  flake.nixosModules.gamescope = {
    programs.gamescope = {
      enable = true;
      capSysNice = true; # allows realtime/nice priority -> lower latency
      args = [
        "--rt" # realtime scheduling
        "--expose-wayland" # let Wayland games see the host compositor
      ];
    };
  };
}
