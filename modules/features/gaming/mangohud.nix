{
  flake.homeModules.mangohud =
    { ... }:
    {
      programs.mangohud = {
        enable = true;
        enableSessionWide = false;
        settings = {
          fps_limit = 0;
          gpu_stats = true;
          cpu_stats = true;
          ram = true;
          vram = true;
          frame_timing = true;
          frametime = true;
          gpu_temp = true;
          cpu_temp = true;
          fps = true;
          engine_version = true;
          vulkan_driver = true;
          wine = true;
          position = "top-left";
          toggle_hud = "SUPER+H";
        };
      };
    };
}
