# 📺 X Server

- `services.xserver`
  - `enable = true`\
    ▶️ enables the X11 server
  - `displayManager`
    - `gdm = true`\
      ▶️ turns on GDM
    - `wayland = true`\
      ▶️ enables Wayland session support in GDM

# Hyprland

- `programs.hyprland.enable = true`  
  ▶️ enables the Hyprland Wayland compositor

# 📦 System packages

- `environment.systemPackdages`
  - `wayland`\
    ▶️ core Wayland protocol libraries
  - `xwayland`\
    ▶️ compatibility for running X11 apps under Wayland
