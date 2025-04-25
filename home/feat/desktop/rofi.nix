{ config, pkgs, ... }: {
  programs.rofi = {
    enable = true;
    cycle = true;
    pass = { };
    location = "center";
    plugins = with pkgs; [ rofi-calc rofi-emoji ];
    extraConfig = {
      hide-scrollbar = true;
      show-icons = true;
    };
    font = "FiraCode Nerd Font 12";
  };
}
