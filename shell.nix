{
  pkgs ? import <nixpkgs> { },
  ...
}:
{
  default = pkgs.mkShell {
    NIX_CONFIG = "extra-experimental-features = nix-command flakes ca-derivations";
    nativeBuildInputs = with pkgs; [
      nix # ------------> The Nix package manager
      home-manager # ---> A tool to manage user environments with Nix
      git # ------------> The version control system
      sops # -----------> A tool for managing secrets
      ssh-to-age # -----> A tool for converting SSH keys to Age keys
      gnupg # ----------> The GNU Privacy Guard for encryption and signing
      age # ------------> A simple, modern, and secure file encryption tool
      nixos-anywhere # ->
    ];
  };
}
