{ pkgs, lib, ... }:
{
  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
        "ca-derivations" # -> The hash is based on the output rather than the inputs.
      ];
      warn-dirty = false;
    };
  };
}
