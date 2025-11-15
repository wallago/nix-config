{ pkgs ? import <nixpkgs> { }, ... }: {
  minicava = pkgs.callPackage ./minicava.nix { };
}
