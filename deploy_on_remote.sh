 nixos-anywhere switch \
   --flake .#enma  \
   --copy-host-keys \
   --target-host nixos@192.168.10.116  
   #--generate-hardware-config nixos-generate-config hosts/enma/hardware-configuration.nix \
   # --extra-files /persistent/etc/ssh \
