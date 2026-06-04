{ inputs, ... }:
{
  flake.nixosModules.qylock = {
    imports = [ inputs.qylock.nixosModules.default ];

    programs.qylock = {
      enable = true;
      theme = "paper";
    };
  };
}
