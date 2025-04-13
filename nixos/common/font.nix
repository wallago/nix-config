{ pkgs, ... }:
{
  fonts = {
    enableDefaultPackages = true;
    fontconfig.enable = true;
    packages = with pkgs; [
      nerd-fonts.fira-code
      nerd-fonts.fira-mono
      nerd-fonts._0xproto
      noto-fonts-emoji
    ];
  };
}
