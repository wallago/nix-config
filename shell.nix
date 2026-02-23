{
  pkgs ? import <nixpkgs> { },
  inputs,
  ...
}:
let
in
{
  default = pkgs.mkShell {
    NIX_CONFIG = "extra-experimental-features = nix-command flakes ca-derivations";
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
      ${inputs.project-banner.packages.${pkgs.system}.default}/bin/project-banner \
        --owner "wallago" \
        --logo " 󰖌 " \
        --product "Nixos" \
        --part "config" \
        --code "WL24-NIXO-CF01" \
        --tips "==== SSH =====" \
        --tips "SOCKS5 proxy server for work: ssh -D 9090 tuna@10.100.0.4 -p 2222" \
        --tips "==== SOPS ====" \
        --tips "add SOPS_AGE_KEY=\$(ssh-to-age -private-key -i ~/.ssh/id_ed25519) if no yubikey" \
        --tips "update file: sops updatekeys <path to sops file>" \
        --tips "edit file: sops <path to sops file>"
    '';
  };
}
