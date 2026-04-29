{ inputs, ... }:
{
  flake.nixosModules.qylock = {
    imports = [ inputs.qylock.nixosModules.default ];

    programs.qylock = {
      enable = true;
      theme = "pixel-coffee";
      sddmTheme = "pixel-coffee";
    };
  };
}
