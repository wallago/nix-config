{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts._0xproto
    noto-fonts-emoji
  ];

  fonts.fontconfig.enable = true;
}
