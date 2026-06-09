{
  flake.nixosModules.nixOverlays = {
    nixpkgs.overlays = [
      (final: prev: {
        kulala-core = prev.kulala-core.overrideAttrs (old: {
          node_modules = old.node_modules.overrideAttrs (_: {
            outputHash = "sha256-XQlBawD3vt8pVc7Gy9XeiGie89HWbljNJt7kUEDaDKk=";
          });
        });
      })
    ];
  };
}
