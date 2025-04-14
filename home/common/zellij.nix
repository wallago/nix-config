{ config, ... }:
{
  programs.zellij = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      show_startup_tips = false;
      theme = "custom";
      themes.custom = {
        fg = config.colorscheme.colors.on_surface;
        bg = config.colorscheme.colors.surface;
        black = config.colorscheme.colors.surface;
        red = config.colorscheme.colors.on_primary;
        green = config.colorscheme.colors.green;
        yellow = config.colorscheme.colors.yellow;
        blue = config.colorscheme.colors.blue;
        magenta = config.colorscheme.colors.magenta;
        cyan = config.colorscheme.colors.cyan;
        white = config.colorscheme.colors.on_surface;
        orange = config.colorscheme.colors.orange;
      };
    };
  };
}
