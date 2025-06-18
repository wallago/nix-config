{ config, ... }: {
  imports = [ ./steam.nix ./mangohud.nix ];

  home.persistence = {
    "/persist/${config.home.homeDirectory}" = {
      allowOther = true;
      directories = [ "Games" ];
    };
  };
}
