{ config, pkgs, ... }:
{
  programs.kitty = {
    enable = true;
    font = {
      name = "0xProto Nerd Font";
      size = 11.0;
    };
    settings = {
      shell = "fish";
      window_padding_width = 4;
    };
    extraConfig = ''
      italic_font auto
      bold_font auto
      bold_italic_font auto
    '';
  };

  home.sessionVariables = {
    TERMINAL = "kitty";
  };
}
