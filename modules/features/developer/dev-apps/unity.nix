{
  flake.nixosModules.unity =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        unityhub
      ];
    };
}
