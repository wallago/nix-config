{
  flake.nixosModules.userWallago =
    {
      pkgs,
      config,
      lib,
      ...
    }:
    let
      groups = config.preferences.user.groups;
    in
    {
      users.users.wallago = {
        extraGroups = [
          # Grants its members elevated privileges
          "wheel"
          # Allows controlling network connections via NetworkManager
          "networkmanager"
          # Allow access to GPU and capture devices (/dev/dri/*, /dev/video*)
          "video"
          # Allow access to sound cards (/dev/snd/*)
          "audio"
        ] # Allow raw access to block devices (/dev/sd*, /dev/nvme*)
        ++ lib.optional groups.disk.enable "disk"
        # Allow access to serial ports (/dev/ttyACM*, /dev/ttyUSB*) for flashing MCUs
        ++ lib.optional groups.serial.enable "dialout";
        shell = pkgs.fish;
        hashedPasswordFile = config.sops.secrets.wallago-password.path;
      };
    };
}
