{ inputs, ... }:
{
  flake.nixosModules.nix =
    { pkgs, ... }:
    {
      imports = [
        inputs.nix-index-database.nixosModules.nix-index
      ];
      programs.nix-index-database.comma.enable = true;

      programs.direnv = {
        enable = true;
        silent = false;
        loadInNixShell = true;
        nix-direnv = {
          enable = true;
        };
      };

      nix = {
        gc = {
          automatic = true;
          dates = "weekly";
          options = "--delete-older-than 30d";
        };
        optimise.automatic = true;
        settings = {
          auto-optimise-store = true;
          experimental-features = [
            "nix-command"
            "flakes"
          ];
        };
      };

      system.stateVersion = "26.05";

      # Run unpatched dynamic binaries
      programs.nix-ld.enable = true;

      nixpkgs.config.allowUnfree = true;

      # System-wide Nix CLI helpers
      environment.systemPackages = with pkgs; [
        nix-output-monitor # `nom` — pretty build output
        nvd # diff between two system generations
        nh # ergonomic wrapper for nixos-rebuild
      ];
    };
}
