{
  flake.homeModules.sprout =
    { pkgs, ... }:
    {
      home.packages = [
        (pkgs.rustPlatform.buildRustPackage (finalAttrs: {
          pname = "sprout";
          version = "0.1.5";
          src = pkgs.fetchFromGitHub {
            owner = "kb019";
            repo = "sprout";
            tag = "v${finalAttrs.version}";
            hash = "sha256-TLoSD02x0Fyhx4e/2XcPAv7Z5LS8jitGNfMXPsqGnps=";
          };
          cargoHash = "sha256-MFT32cSYB2NjdWVmKZWPBsfJF+WZ9qWqLoOidXJYnWo=";
          # Upstream stores habit.db next to the binary (read-only in the store)
          postPatch = ''
            substituteInPlace src/main.rs --replace-fail \
              'exe_dir.join("habit.db")' \
              '{ let d = dirs::home_dir().unwrap_or_default().join("sync-habit"); std::fs::create_dir_all(&d)?; d.join("habit.db") }'
          '';
          doCheck = false;
        }))
      ];
    };
}
