{
  flake.nixosModules.nixOverlays = {
    nixpkgs.overlays = [
      (final: prev: { waypipe = prev.waypipe.override { ffmpeg = prev.ffmpeg_8; }; })
    ];
  };
}
