{ inputs, ... }:
{
  flake.nixosModules.impermanence = {
    imports = [
      inputs.impermanence.nixosModules.impermanence
    ];

    environment.persistence = {
      "/persist" = {
        files = [
          "/etc/machine-id"
        ];
        directories = [
          "/var/lib/fprint"
          "/var/lib/systemd"
          "/var/lib/nixos"
          "/var/log"
          "/srv"
        ];
      };
    };

    # Lets a FUSE filesystem mounted by user A be visible to user B
    programs.fuse.userAllowOther = true;
  };
}
