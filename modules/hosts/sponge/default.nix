{ self, inputs, ... }:
{
  flake.nixosConfigurations.sponge = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.spongeModule
    ];
  };

  # This is your home.nix, your module where you configure home-manager
  # It's imported in your nixos configuration above, and also used in a standalone configuration below
  flake.homeModules.USERNAMEModule =
    { pkgs, ... }:
    {
      programs.bash.enable = true;
      programs.bash.shellAliases.ll = "ls -l";

      home.packages = [ pkgs.hello ];
      home.stateVersion = "24.11";
    };

}
