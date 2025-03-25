{
  pkgs ? import <nixpkgs> { },
  ...
}:
{
  # Creates a Nix development shell.
  default = pkgs.mkShell {
    NIX_CONFIG = "extra-experimental-features = nix-command flakes ca-derivations";
    nativeBuildInputs = with pkgs; [
      # Core tools for managing the Nix environment.
      nix
      home-manager
      git
      # Tools for secrets management (e.g., SOPS + age for encrypted secrets).
      sops
      ssh-to-age
      gnupg
      age
    ];
  };
}
