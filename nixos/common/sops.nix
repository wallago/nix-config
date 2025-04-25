{ inputs, config, ... }:
let
  # Check if a ed25519 type
  isEd25519 = k: k.type == "ed25519";
  getKeyPath = k: k.path;
  keys = builtins.filter isEd25519 config.services.openssh.hostKeys;
in {
  imports = [ inputs.sops-nix.nixosModules.sops ];

  sops = {
    # Configure `sops` to use the filtered list to decrypt age-encrypted secrets
    age.sshKeyPaths = map getKeyPath keys;
  };
}
