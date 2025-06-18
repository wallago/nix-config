{ ... }: {
  imports = [ ./default.nix ];
  services.xserver.videoDrivers = [ "intel" ];
}
