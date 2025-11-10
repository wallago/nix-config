{ config, ... }: {
  imports = [ ./steam.nix ./heroic.nix ];

  home.persistence = {
    "/persist/${config.home.homeDirectory}" = {
      allowOther = true;
      directories = [ "Games/" ];
    };
  };
}
