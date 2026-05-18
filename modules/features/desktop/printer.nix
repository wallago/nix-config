{
  flake.nixosModules.printer =
    { pkgs, ... }:
    {
      services.printing = {
        enable = true;
        drivers = with pkgs; [
          hplip
          gutenprint
        ];
      };

      environment.systemPackages = with pkgs; [
        cups-pk-helper
      ];
    };
}
