{
  flake.nixosModules.gamescope = {
    # VKD3D_DISABLE_EXTENSIONS=VK_NV_raw_access_chains \
    # gamescope -W 1920 -H 1080 -r 120 -f \
    # --backend wayland --expose-wayland \
    # --grab \
    # --mouse-sensitivity 0.2 \
    # --rt \
    # --mangoapp \
    # --prefer-output DP-3 \
    # -- %command%
    programs.gamescope = {
      enable = true;
    };
  };
}
