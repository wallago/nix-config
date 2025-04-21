 nixos-anywhere switch \
   --build-on-local \
   --flake .#enma  \
   --target-host nixos@192.168.10.116  \
   --generate-hardware-config nixos-generate-config hosts/enma/hardware-configuration.nix
