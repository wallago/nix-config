{ pkgs ? import <nixpkgs> { }, inputs, ... }:
let
in {
  default = pkgs.mkShell {
    NIX_CONFIG =
      "extra-experimental-features = nix-command flakes ca-derivations";
    buildInputs = [
      pkgs.sops
      pkgs.ssh-to-age
      pkgs.gnupg
      pkgs.age
      pkgs.nixos-anywhere
      pkgs.pam_u2f
      inputs.nix-bootstrap.packages.${pkgs.system}.default
      inputs.nix-deployer.packages.${pkgs.system}.default
    ];
    shellHook = ''
      echo "Helpers: 
      - nix-store --verify --check-contents --repair
      - find /nix/store -name \$name
      "
    '';
  };
}
