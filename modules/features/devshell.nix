{ inputs, ... }:
{
  perSystem =
    { pkgs, system, ... }:
    let
      localSettings = builtins.toJSON {
        permissions = {
          allow = [
            # Nix
            "Bash(nix flake check*)"
            "Bash(nix eval*)"
            "Bash(nixos-rebuild dry-build*)"
            "Bash(statix check*)"
            "Bash(deadnix*)"
            "Bash(just*)"
            "Bash(nix build --dry-run*)"
            "Bash(nix search nixpkgs*)"
            "Bash(curl -s https://search.nixos.org*)"
          ];
        };
        enabledPlugins = {
          "claude-md-management@claude-plugins-official" = true;
          "superpowers@claude-plugins-official" = true;
          "context7@claude-plugins-official" = true;
          "code-review@claude-plugins-official" = true;
          "code-simplifier@claude-plugins-official" = true;
          "github@claude-plugins-official" = true;
        };
      };
    in
    {
      devShells.default = pkgs.mkShell {
        packages = with pkgs; [
          just

          inputs.claude-code.packages.${system}.default
          nodejs # deps of claude

          # Just deps
          sops
          manix
          committed
          lychee
          typos
          statix
          deadnix
        ];
        shellHook = ''
          mkdir -p .claude
          echo '${localSettings}' > .claude/settings.local.json
        '';
      };
    };
}
