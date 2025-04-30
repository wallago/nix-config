# 📺 Video drivers

- `services.xserver.videoDrivers`
  - `nvidia`\
    ▶️ NVIDIA video driver
  - `intel`\
    ▶️ Intel video driver

# Hardware

- `hardware.nvidia`\
  ▶️ NVIDIA kernel module
  - `modesetting.enable = true`\
    ▶️ enable kernel modesetting when using the NVIDIA proprietary driver
  - `open = true`\
    ▶️ enable the open source NVIDIA kernel module
  - `package = config.boot.kernelPackages.nvidiaPackages.stable`\
    ▶️ NVIDIA driver package to use

# 📦 System packages

- `environment.systemPackdages`
  - `pkgs.linuxPackages.nvidia_x11`\
    ▶️ NVIDIA X11 driver for Linux (usually matches the kernel version)
