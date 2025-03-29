{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:
let
  username = "yc";
in
{
  imports = [
    # Includes the Home Manager module from the home-manager input in NixOS configuration
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    users.${username} = {
      nix = {
        package = lib.mkDefault pkgs.nix;
        settings = {
          experimental-features = [
            # Enables the new Nix CLI commands
            "nix-command"
            # Enables Nix flakes
            "flakes"
            # The hash is based on the output rather than the inputs.
            "ca-derivations"
          ];
          warn-dirty = false;
        };
      };

      programs = {
        home-manager.enable = true;
        git.enable = true;
      };

      systemd.user.startServices = "sd-switch";

      home = {
        username = "${username}";
        homeDirectory = "/home/${username}";
        sessionPath = [ "$HOME/.local/bin" ];
        sessionVariables = {
          FLAKE = "$HOME/Documents/NixConfig";
        };
        stateVersion = "${config.system.nixos.release}";
      };
    };

    useUserPackages = true;
    useGlobalPkgs = true;
  };

  users.mutableUsers = false;
  users.users."${username}" = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "video"
      "audio"
    ];
    password = "${username}";
  };
}
