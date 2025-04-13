{
  pkgs ? import <nixpkgs> { },
  ...
}:
rec {
  minicava = pkgs.callPackage ./minicava.nix { };
}
