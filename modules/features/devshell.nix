{ inputs, ... }:
{
  perSystem =
    { pkgs, system, ... }:
    {
      devShells.default = pkgs.mkShell {
        packages = with pkgs; [
          just

          inputs.claude-code.packages.${system}.default
          nodejs # deps of claude

          # repo tooling
          typos
          committed
          git-cliff
          lychee

          # nix tooling
          nixfmt
          statix
          deadnix
          manix
          sops
        ];
      };
    };
}
