{ inputs, ... }:
{
  flake.nixosModules.impermanence = {
    imports = [
      inputs.impermanence.nixosModules.impermanence
    ];

    environment.persistence."/persist" = {
      hideMounts = true;
      directories = [
        "/var/log"
        "/var/lib/bluetooth"
        "/var/lib/nixos"
        "/var/lib/systemd/coredump"
        "/etc/NetworkManager/system-connections"
      ];
      files = [
        "/etc/machine-id"
      ];
    };
  };

  flake.homeModules.impermanence =
    { config, lib, ... }:
    {
      home.persistence = {
        "/persist/".directories = lib.optionals config.preferences.developer.enable [
          "Personal-Projects/"
          "Work-Projects/"
        ];
      };
    };
}
