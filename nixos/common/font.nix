{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    noto-fonts-emoji
  ];
}
