{ inputs, ... }: {
  flake.homeModules.bagels = { pkgs, config, ... }: {
    imports = [ inputs.bp-to-bagels-csv.homeModules.default ];

    programs.bp-to-bagels-csv.enable = true;

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
