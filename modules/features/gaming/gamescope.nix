{
  flake.nixosModules.gamescope = {
    # VKD3D_DISABLE_EXTENSIONS=VK_NV_raw_access_chains gamescope -W 1920 -H 1080 -r 120 -f --mouse-sensitivity 1.0 --mangoapp --prefer-output DP-3 --rt --grab -- %command%
    programs.gamescope = {
      enable = true;
    };
  };
}
