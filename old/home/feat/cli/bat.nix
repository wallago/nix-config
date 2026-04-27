{ pkgs, ... }: {
  programs.bat = {
    enable = true;
    config.theme = "base16";
    extraPackages = with pkgs.bat-extras; [
      batdiff
      batman
      batpipe
      batwatch
      prettybat
    ];
  };
}
