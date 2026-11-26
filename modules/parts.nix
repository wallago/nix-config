{ inputs, ... }:
let
  # The flake-parts setup this flake runs on. Exported as
  # flakeModules.default so a flake that defines extra hosts on top of
  # these modules gets the same setup.
  common = {
    imports = [
      inputs.home-manager.flakeModules.home-manager
      inputs.disko.flakeModules.default
    ];

    systems = [
      "x86_64-linux"
      "aarch64-linux"
    ];

    perSystem =
      { pkgs, ... }:
      {
        formatter = pkgs.nixfmt-tree;
      };
  };
in
{
  imports = [
    inputs.flake-parts.flakeModules.flakeModules
    common
  ];

  flake.flakeModules.default = common;
}
