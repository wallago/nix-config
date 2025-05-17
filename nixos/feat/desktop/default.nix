{
  imports = [ ./wayland.nix ./hyprland.nix ];
  security.pam.services.hyprlock = {
    text = ''
      auth include login
      account include login
    '';
  };
}
