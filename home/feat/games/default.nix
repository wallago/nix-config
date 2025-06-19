{ config, ... }: {
  imports = [ ./steam.nix ];

  home.persistence = {
    "/persist/${config.home.homeDirectory}" = {
      allowOther = true;
      directories = [ "Games/" ];
    };
  };
}
