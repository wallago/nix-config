{ config, ... }:
let
  inherit (config) colorscheme;
  hash = builtins.hashString "md5" (builtins.toJSON colorscheme.colors);
in
{
  programs.zellij = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      show_startup_tips = false;
      theme = "nix-${hash}";
      themes."nix-${hash}" = import ./theme.nix { inherit colorscheme; };
    };
  };
}
