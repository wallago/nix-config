{ pkgs ? import <nixpkgs> { }, ... }: {
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
  };
}
