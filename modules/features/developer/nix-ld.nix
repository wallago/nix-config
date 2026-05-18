{
  flake.nixosModules.nix-ld = {
    # Run unpatched dynamic binaries
    programs.nix-ld.enable = true;
  };
}
