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
      flake-registry = false; # Disable global flake registry
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than +10";
    };

    # Add each flake input as a registry and nix_path
    # Add each flake input as a registry and nix_path
    registry =
      lib.mkDefault (lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs);
    nixPath =
      lib.mkDefault (lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs);
  };

  programs.nix-ld.enable = true; # Run unpatched dynamic
}
