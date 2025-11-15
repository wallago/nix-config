{ pkgs, config, ... }: {
  home.packages = [
    (pkgs.steam.override { extraPkgs = p: [ p.gamescope ]; })
    pkgs.gamescope
    pkgs.protontricks
  ];

  home.persistence = {
    "/persist/${config.home.homeDirectory}" = {
      allowOther = true;
      directories = [ ".local/share/Steam/" ];
    };
  };
}

