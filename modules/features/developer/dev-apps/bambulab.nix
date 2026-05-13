{
  flake.nixosModules.bambulab =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        bambu-studio
      ];
    };
}
