{ pkgs, lib, ... }:
let
  nautilus = let nautilus = lib.getExe pkgs.nautilus;
  in pkgs.writeTextDir "share/applications/files-explorer.desktop" ''
    [Desktop Entry]
    Name=Files Explorer
    Exec=${nautilus}
    Type=Application
    Categories=Files Explorer;
  '';
in { home.packages = [ nautilus pkgs.nautilus ]; }
