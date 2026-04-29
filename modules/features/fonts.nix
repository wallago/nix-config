{
  flake.nixosModules.fonts =
    { pkgs, ... }:
    {
      fonts = {
        packages = with pkgs; [
          nerd-fonts.fira-code

          # Emoji + CJK fallback so you don't see tofu boxes
          noto-fonts
          noto-fonts-color-emoji
          noto-fonts-cjk-sans
        ];

        fontconfig.defaultFonts = {
          monospace = [ "FiraCodeMono Nerd Font" ];
          sansSerif = [ "Noto Sans" ];
          serif = [ "Noto Serif" ];
        };
      };
    };
}
