{
  flake.homeModules.mangohud =
    { ... }:
    {
      programs.mangohud = {
        enable = true;
        enableSessionWide = false;
        settings = {
          fps_limit = 0;
          fps = true;

          gpu_stats = true;
          gpu_temp = true;

          cpu_stats = true;
          cpu_temp = true;

          ram = true;
          vram = true;

          frame_timing = true;
          frametime = true;

          wine = true;

          # --- appearance
          legacy_layout = false; # modern compact layout with separators
          round_corners = 8; # rounded background box
          background_alpha = 0.4; # semi-transparent backdrop
          alpha = 0.9; # text opacity
          font_size = 22;
          cellpadding_y = -0.1; # tighter vertical spacing

          # --- colors
          background_color = "1A1B26";
          text_color = "C0CAF5";
          gpu_color = "9ECE6A";
          cpu_color = "7AA2F7";
          vram_color = "BB9AF7";
          ram_color = "F7768E";
          frametime_color = "7DCFFF";

          position = "top-left";
          toggle_hud = "Ctrl_L+H";
        };
      };
    };
}
