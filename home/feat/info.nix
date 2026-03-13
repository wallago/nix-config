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
          "m" = [ "left" ];
          "o" = [ "right" ];
          "C-m" = [ "prev" ];
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

          # "h" = [ "article search next" ];
          # "H" = [ "article search previous" ];
          # "y" = [ "mark current article" ];
          # "Y" = [ "mark all articles in article list?" ];
          # "0 y" = [ "mark current article and all above in article list?" ];
          # "$ y" = [ "mark current article and all below in article list?" ];
          # "M-y" = [ ":mark" ];
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

# "enter"     = ["_submit"]
# "esc"       = ["_abort"]
# "C-g"       = ["_abort"]
# "C-u"       = ["_clear"]
# "space"     = ["toggle"]
# "C-f"       = ["pagedown"]
# "C-b"       = ["pageup"]
# "g g"       = ["gotofirst"]
# "G"         = ["gotolast"]
# "q"         = ["confirm quit"]
# "C-c"       = ["quit"]
# "x"         = ["scrape"]
# "g f"       = ["focus feeds"]
# "g a"       = ["focus articles"]
# "g c"       = ["focus content"]
# ":"         = ["cmd"]
# "l"         = ["next"]
# "h"         = ["prev"]
# "tab"       = ["nextc"]
# "backtab"   = ["prevc"]
# "o"         = ["open", "in articles read", "in articles nextunread"]
# "O"         = ["open unread", "confirm in articles read articles %"]
# "s"         = ["sync"]
# "r"         = ["read", "in articles nextunread"]
# "t"         = ["cmd tag"]
# "R"         = ["confirm in articles read %"]
# "0 r"       = ["confirm in articles read above"]
# "$ r"       = ["confirm in articles read below"]
# "M-r"       = ["cmd read"]
# "u"         = ["unread"]
# "U"         = ["confirm in articles unread %"]
# "0 u"       = ["confirm in articles unread above"]
# "$ u"       = ["confirm in articles unread below"]
# "M-u"       = ["cmd unread"]
# "m"         = ["mark"]
# "M"         = ["confirm in articles mark %"]
# "0 m"       = ["confirm in articles mark above"]
# "$ m"       = ["confirm in articles mark below"]
# "M-m"       = ["cmd mark"]
# "v"         = ["unmark"]
# "V"         = ["confirm in articles unmark %"]
# "0 v"       = ["confirm in articles unmark above"]
# "$ v"       = ["confirm in articles unmark below"]
# "1"         = ["show all"]
# "2"         = ["show unread"]
# "3"         = ["show marked"]
# "z"         = ["zen"]
# "/"         = ["_search"]
# "n"         = ["searchnext"]
# "N"         = ["searchprev"]
# "="         = ["cmd filter "]
# "+ r"       = ["filterclear"]
# "+ +"       = ["filterapply"]
# "\\"        = ["cmd sort "]
# "| |"       = ["sortreverse"]
# "| r"       = ["sortclear"]
# "c w"       = ["cmd rename"]
# "c d"       = ["confirm remove"]
# "c x"       = ["confirm removeall"]
# "c f"       = ["cmd feedadd"]
# "c e"       = ["confirm feedadd https://github.com/christo-auer/eilmeldung/releases.atom eilmeldung releases"]
# "c a"       = ["cmd categoryadd"]
# "c u"       = ["cmd feedchangeurl"]
# "c y"       = ["yank"]
# "c p"       = ["paste after"]
# "c P"       = ["paste before"]
# "c c"       = ["cmd tagchangecolor"]
# "S"         = ["cmd share"]
# "?"         = ["helpinput"]
