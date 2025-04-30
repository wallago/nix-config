# 🧩 Flake Overlays

- `flake-inputs`\
  ▶️ provide aliases for flake inputs' packages based on the current system  
  ▶️ for each flake input, use either: + `inputs.${flake}.legacyPackages.${system}`\
  ▶️ fallback to this if available + `inputs.${flake}.packages.${system}`\
  ▶️ used if no `legacyPackages` are defined
- `stable = inputs.nixpkgs-stable.legacyPackages.${system}`\
  ▶️ expose a stable channel of Nixpkgs as `pkgs.stable`
- `additions = import ../pkgs { pkgs = final; }`\
  ▶️ add your custom packages located in `../pkgs`
- `rust = inputs.rust-overlay.overlays.default`\
  ▶️ include the Rust overlay to provide custom Rust toolchains and tools
