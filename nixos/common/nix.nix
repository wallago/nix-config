{ inputs, lib, ... }:
let flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
in {
  nix = {
    settings = {
      trusted-users = [ "root" "@wheel" ];
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
        "ca-derivations" # -> The hash is based on the output rather than the inputs.
      ];
      warn-dirty = false;
      system-features = [
        "kvm" # ----------> Enable KVM virtualization support
        "big-parallel" # -> Enable support for parallel builds
        "nixos-test" # ---> Enable features related to NixOS testing
      ];
      flake-registry = ""; # Disable global flake registry
      download-buffer-size = 524288000;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than +10";
    };

    registry = (lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs);
    nixPath = (lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs);
  };

  programs.nix-ld.enable = true; # Run unpatched dynamic
}
