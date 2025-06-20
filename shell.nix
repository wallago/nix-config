{ pkgs ? import <nixpkgs> { }, inputs, ... }:
let
in {
  default = pkgs.mkShell {
    NIX_CONFIG =
      "extra-experimental-features = nix-command flakes ca-derivations";
    nativeBuildInputs = with pkgs; [
      sops
      ssh-to-age
      gnupg
      age
      nixos-anywhere
      pam_u2f
    ];
    buildInputs = [ inputs.nix-bootstrap.packages.${pkgs.system}.default ];
    shellHook = ''
      echo "Helpers: 
      -  nix-store --verify --check-contents --repair
      "
    '';
  };
}
