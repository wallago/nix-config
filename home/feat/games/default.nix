{ config, ... }:
{
  imports = [
    ./steam.nix
    ./heroic.nix
  ];

  home.persistence = {
    "/persist/" = {
      directories = [ "Games/" ];
    };
  };
}
