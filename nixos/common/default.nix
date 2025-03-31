{ hostname, ... }:
{
  imports = [
    ./grub.nix
    ./home.nix
    (import ./network.nix { inherit hostname; })
    ./fish.nix
  ];

}
