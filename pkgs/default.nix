{
  pkgs ? import <nixpkgs> { },
  ...
}:
{
  eilmeldung = pkgs.callPackage ./eilmeldung.nix { };
}
