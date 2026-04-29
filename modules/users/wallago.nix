{
  flake.nixosModules.userWallago =
    { pkgs, config, ... }:
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
        ];
        shell = pkgs.fish;
        hashedPasswordFile = config.sops.secrets.wallago-password.path;
        openssh.authorizedKeys = {
          keys = [ ]; # to fill
        };
      };
    };
}
