{
  imports = [
    ./wayland.nix
    ./hyprland.nix
    ./sddm.nix
  ];
  security.pam.services.hyprlock = {
    text = ''
      auth include login
      account include login
    '';
  };
}
