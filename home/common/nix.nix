{ pkgs, lib, ... }:
{
  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      experimental-features = [
        # Enables the new Nix CLI commands
        "nix-command"
        # Enables Nix flakes
        "flakes"
        # The hash is based on the output rather than the inputs.
        "ca-derivations"
      ];
      warn-dirty = false;
    };
  };
}
