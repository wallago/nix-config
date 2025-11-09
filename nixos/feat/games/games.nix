{ pkgs, ... }: {
  programs.gamescope.enable = true;
  programs.gamemode.enable = true;
  environment.systemPackages = with pkgs; [ mangohud heroic ];
}
