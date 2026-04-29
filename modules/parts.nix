{ inputs, ... }:
{
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
}
