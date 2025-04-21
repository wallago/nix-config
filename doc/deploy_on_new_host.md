# Deploying on new host

# Steps 

1. Generate a custom ISO image
2. Boot the target host into the custom ISO
3. Execute a script from the source host that will:
    + Generate target host's hardware config
    + Generate an age key for the target host to use sops
    + Update nix-secrets with the new key
    + Push changes to nix-secrets
    + Add host's hardware config to nix-config
    + Remotely install NixOS using the full nix-config

