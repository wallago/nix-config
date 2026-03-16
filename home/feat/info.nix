{ config, ... }:
let
  inherit (config) colorscheme;
  c = colorscheme.colors;
in
{
  programs.eilmeldung = {
    enable = true;
    settings = {
      refresh_fps = 60;
      article_scope = "unread";
      theme.color_palette = {
        accent_primary = "${c.magenta}";
        accent_quaternary = "${c.green}";
        accent_secondary = "${c.cyan}";
        accent_tertiary = "${c.blue}";
        background = "${c.surface_variant}";
        error = "${c.red}";
        foreground = "${c.on_surface}";
        highlight = "${c.yellow}";
        flagged = "${c.red}";
        info = "${c.magenta}";
        muted = "${c.outline}";
        warning = "${c.yellow}";
      };
      input_config = {
        mappings = {
          "q" = [ "quit" ];
          "e" = [ "down" ];
          "i" = [ "up" ];
          "C-e" = [ "in feeds down" ];
          "C-i" = [ "in feeds up" ];
          "E" = [ "in content down" ];
          "I" = [ "in content up" ];
          # "E" = [ "in article down" ];
          # "I" = [ "in article up" ];
          "n" = [ "left" ];
          "o" = [ "right" ];
          "C-n" = [ "prev" ];
          "C-o" = [ "next" ];
          "w" = [
            "open"
            "in articles read"
            "in articles nextunread"
          ];
          "W" = [
            "open unread"
            "confirm in articles read articles %"
          ];

          "h" = [ "searchnext" ];
          "H" = [ "searchprev" ];

          # "k" = [ "invert flags current article,down in article list" ];
          # "0 k" = [ "invert flags current article and all above" ];
          # "$ k" = [ "invert flags current article and all below" ];
          # "K" = [ "invert flags all articles" ];
          # "M-k" = [ ":flaginvert" ];
          # "j" = [ "open default enclosure" ];
          # "J" = [ ":openenclosure" ];
        };
      };
    };
  };
}
