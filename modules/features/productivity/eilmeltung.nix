{
  flake.homeModules.eilmeldung = {
    programs.eilmeldung = {
      enable = true;
      settings = {
        article_list_focused_height = "50%";
        article_content_focused_height = "50%";
        refresh_fps = 60;
        article_scope = "unread";
        input_config = {
          mappings = {
            "q" = [ "quit" ];
            "e" = [ "down" ];
            "i" = [ "up" ];
            "C-e" = [ "in feeds down" ];
            "C-i" = [ "in feeds up" ];
            "E" = [ "in content down" ];
            "I" = [ "in content up" ];
            "n" = [ "left" ];
            "o" = [ "right" ];
            "C-n" = [ "prev" ];
            "C-o" = [ "next" ];
            "w" = [
              "open"
              "in articles read"
              "in articles nextunread"
            ];
            "J" = [
              "open unread"
              "confirm in articles read articles %"
            ];
            "h" = [ "searchnext" ];
            "H" = [ "searchprev" ];
          };
        };
      };
    };
  };
}
