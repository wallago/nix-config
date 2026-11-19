{
  flake.nixosModules.dms = {
    programs.dux-shell = {
      enable = true;
    };
  };
}
