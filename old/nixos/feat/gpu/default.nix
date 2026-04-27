{ pkgs, ... }: {
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [ vulkan-loader ];
    extraPackages32 = with pkgs; [ vulkan-loader ];
  };
}
