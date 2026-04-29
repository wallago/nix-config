{ inputs, ... }:
{
  perSystem =
    { pkgs, system, ... }:
    {
      devShells.default = pkgs.mkShell {
        packages = with pkgs; [
          just
          inputs.claude-code.packages.${system}.default
        ];
      };
    };
}
