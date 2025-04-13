{
  inputs,
  outputs,
}:
let
  inherit (inputs.nixpkgs) lib;

  # Check if a package is not marked as broken
  notBroken = pkg: !(pkg.meta.broken or false);
  # Check if a package is redistributable
  isDistributable = pkg: (pkg.meta.license or { redistributable = true; }).redistributable;
  # Check if a package supports a given system (platform)
  hasPlatform = sys: pkg: lib.elem sys (pkg.meta.platforms or [ sys ]);
  # Filter valid packages for a given system
  filterValidPkgs =
    sys: pkgs:
    lib.filterAttrs (
      _: pkg: lib.isDerivation pkg && hasPlatform sys pkg && notBroken pkg && isDistributable pkg
    ) pkgs;

  # Get the top-level configuration for a given system
  getConfigTopLevel = _: cfg: cfg.config.system.build.toplevel;
in
{
  pkgs = lib.mapAttrs filterValidPkgs outputs.packages;
  hosts = lib.mapAttrs getConfigTopLevel outputs.nixosConfigurations;
}
