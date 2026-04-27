{
  pkgs,
  config,
  inputs,
  lib,
  ...
}:
let
  username = "wallago";
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  imports = [
    (import ./default.nix {
      inherit
        pkgs
        config
        inputs
        lib
        username
        ;
    })
  ];

  users.users.${username} = {
    extraGroups = ifTheyExist [
      "disk" # direct read/write access to raw block devices (/dev/sda, etc.)
      "audio" # access to sound cards (/dev/snd/*)
      "video" # access to GPU and capture devices (/dev/dri/*, /dev/video*).
      "dialout" # access to serial ports (/dev/ttyS*, /dev/ttyUSB*, /dev/ttyACM*)
      "docker" # run Docker without sudo
      "input" # access to raw input devices (/dev/input/*)
      "plugdev" # access to pluggable devices (USB sticks, etc.) via udev rules
      "tss" # access to the TPM chip (/dev/tpm*)
      "networkmanager" # allows controlling network connections via NetworkManager
    ];
    hashedPasswordFile = config.sops.secrets.wallago-password.path;
  };

  users.groups.dialout = { };

  sops.secrets.wallago-password = {
    sopsFile = ../common/secrets.yaml;
    neededForUsers = true;
  };
}
