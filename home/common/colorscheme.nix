{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
let
  wallpapers = inputs.themes.packages.${pkgs.system}.wallpapers;
  tofi = lib.getExe' config.programs.tofi.package "tofi";
in
{
  colorscheme.mode = lib.mkOverride 1499 "dark";

  specialisation =
    let
      modes = [
        "dark"
        "light"
      ];
    in
    lib.listToAttrs (
      lib.flatten (
        map (
          mode:
          lib.mapAttrsToList (name: wp: {
            name = "${name}-${mode}";
            value.configuration = {
              wallpaper = lib.mkForce wp;
              colorscheme.mode = lib.mkOverride 1498 mode;
            };
          }) wallpapers
        ) modes
      )
    );

  home.file.".colorscheme.json".text = builtins.toJSON config.colorscheme;

  home.packages =
    let
      specialisation = pkgs.writeShellScriptBin "specialisation" ''
        profiles="$HOME/.local/state/nix/profiles"
        current="$profiles/home-manager"
        base="$profiles/home-manager-base"
        current_home="$HOME/.local/state/home-manager/gcroots/current-home" # For NixOS

        # Try to get it from NixOS, if so, link it
        if [ -d "$current_home/specialisation" ]; then
          echo >&2 "Using current-home gcroot"
          ln -sfT "$(readlink "$current_home")" "$base"
        # If current contains specialisations, link it as base
        elif [ -d "$current/specialisation" ]; then
          echo >&2 "Using current profile as base"
          ln -sfT "$(readlink "$current")" "$base"
        # Check that $base contains specialisations before proceeding
        elif [ -d "$base/specialisation" ]; then
          echo >&2 "Using previously linked base profile"
        else
          echo >&2 "No suitable base config found. Try 'home-manager switch' or 'nixos-rebuild switch' again."
          exit 1
        fi

        if [ -z "$1" ] || [ "$1" = "list" ] || [ "$1" = "-l" ] || [ "$1" = "--list" ]; then
          find "$base/specialisation" -type l -printf "%f\n"
          exit 0
        fi

        echo >&2 "Switching to ''${1} specialisation"
        if [ "$1" == "base"  ]; then
          "$base/activate"
        else
          "$base/specialisation/$1/activate"
        fi
      '';
    in
    [
      specialisation
    ];
}
