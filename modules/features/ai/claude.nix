{
  flake.homeModules.claude = {
    home.file.".claude/settings.json".text = builtins.toJSON {
      permissions = {
        defaultMode = "plan";
        deny = [
          # Secrets and key material
          "Read(**/.env)"
          "Read(**/.env.*)"
          "Read(**/*.key)"
          "Read(**/*.pem)"
          "Read(**/secrets/**)"
          "Read(**/secrets.yaml)"
          "Read(**/.ssh/**)"
          "Read(**/id_rsa)"
          "Read(**/id_ed25519)"
          "Read(/persist/**)"
        ];
      };
    };
  };
}
