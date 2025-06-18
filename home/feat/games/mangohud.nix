{
  programs.mangohud = {
    enable = true;
    enableSessionWide = true;
    settings = {
      frame_timing = false;
      cpu_stats = true;
      cpu_temp = true;
      gpu_stats = true;
      gpu_temp = true;
      ram = true;
      vram = true;
      hud_compact = true;

      # Hide until toggled
      no_display = true;

      toggle_hud = "Alt+F1";
      toggle_hud_position = "Alt+F2";
      toggle_logging = "Alt+F3";
      reload_cfg = "Alt+F4";
    };
  };
}
