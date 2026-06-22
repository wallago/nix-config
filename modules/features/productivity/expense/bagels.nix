{
  flake.homeModules.bagels = { pkgs, config, ... }: {
    home.packages = [
      (pkgs.symlinkJoin {
        name = "bagels";
        paths = [ pkgs.bagels ];
        nativeBuildInputs = [ pkgs.makeWrapper ];
        postBuild = ''
          wrapProgram $out/bin/bagels \
            --add-flags "--at ${config.home.homeDirectory}/Bagels/"
        '';
      })
    ];
  };
}
