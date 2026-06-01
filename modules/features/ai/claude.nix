{
  flake.homeModules.claude = {
    home.file.".claude/settings.json".text = builtins.toJSON {
      model = "claude-opus-4-8";
      theme = "dark";
      autoUpdates = false;
      includeCoAuthoredBy = false;
      permissions = {
        defaultMode = "plan";
        allow = [
          # Git
          "Bash(git status*)"
          "Bash(git diff*)"
          "Bash(git log*)"
          # Cmd
          "Bash(ls*)"
          "Read(**)"
        ];
        deny = [
          # Secrets and key material
          "Read(**/.env)"
          "Read(**/.env.*)"
          "Read(**/*.key)"
          "Read(**/*.pem)"
          "Read(**/*.age)"
          "Read(**/*.sops.*)"
          "Read(**/secrets/**)"
          "Read(**/secrets.yaml)"
          "Read(**/hosts/*/secrets.nix)"
          "Read(**/.ssh/**)"
          "Read(**/id_rsa)"
          "Read(**/id_ed25519)"
          "Read(/persist/**)"
          # Mutating git ops
          "Bash(git commit*)"
          "Bash(git push*)"
          "Bash(git checkout*)"
          "Bash(git reset*)"
          # NixOS mutations
          "Bash(nixos-rebuild switch*)"
          "Bash(nixos-rebuild boot*)"
          "Bash(nix profile install*)"
          "Bash(nix-env*)"
          # Filesystem mutations
          "Bash(rm *)"
          "Bash(mv *)"
        ];
      };
    };
  };
}
