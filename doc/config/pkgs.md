# 📦 Custom Packages

+ `minicava = pkgs.callPackage ./minicava.nix { }`\
▶️ define the `minicava` package and `callPackage` to automatically inject dependencies

---

# 🎛️ minicava

+ `stdenv.mkDerivation`\
▶️ create a Nix package for `minicava`, a minimal sound visualizer script
    + `src = fetchFromGitHub`\
    ▶️ fetch source from GitHub  
    + `dontBuild = true`\
    ▶️ skip the build phases
    + `dontConfigure = true`\
    ▶️ skip the configure phases 
    + `nativeBuildInputs = [ makeWrapper ]`\
    ▶️ use `makeWrapper` to wrap the script with environment configuration
    + `installPhase`\
    ▶️ install the script and wrap it to include required binaries in `$PATH`  
        + `install -Dm 0755 minicava.sh $out/bin/minicava`    
        ▶️ copy files, create all leading directories and set permissions 
        + `wrapProgram ... --set PATH "$(makeBinPath [ cava gnused ])"`\
        ▶️ ensure `cava` and `gnused` are available when `minicava` runs
    + `meta = { ... }`\
    ▶️ set metadata for the package  

