{ inputs, ... }: {
  flake.homeModules.praline = {
    imports = [ inputs.praline.homeModules.default ];

    programs.praline = {
      enable = true;
      settings = {
        keybindings = {
          scroll_down = "e";
          scroll_up = "i";
          scroll_right = "o";
          scroll_left = "n";
          generate = "g";
          quit = "q";
        };
      };
    };
  };
}
