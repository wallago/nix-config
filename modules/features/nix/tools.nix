{ inputs, ... }:
{
  flake.nixosModules.nixTools =
    { pkgs, ... }:
    {
      imports = [
        inputs.nix-index-database.nixosModules.nix-index
      ];

      programs.nix-index-database.comma.enable = true;

      # System-wide Nix CLI helpers
      environment.systemPackages = with pkgs; [
        nix-output-monitor # `nom` — pretty build output
        nvd # diff between two system generations
      ];

      # ergonomic wrapper for nixos-rebuild
      programs.nh.enable = true;
    };
}
