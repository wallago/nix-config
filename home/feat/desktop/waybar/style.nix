{ lib, config, inputs, }:
let
  inherit (inputs.nix-colors.lib.conversions) hexToRGBString;
  inherit (config.colorscheme) colors;
  toRGBA = color: opacity:
    "rgba(${hexToRGBString "," (lib.removePrefix "#" color)},${opacity})";
  # css
in ''
  * {
    font-family: "${config.fontProfiles.regular.name}, ${config.fontProfiles.monospace.name}";
    font-size: 12pt;
    padding: 0;
    margin: 0 0.4em;
  }

  window#waybar {
    padding: 0;
    border-radius: 0.5em;
    background-color: ${toRGBA colors.surface "0.7"};
    color: ${colors.on_surface};
  }

  .modules-left {
    margin-left: -0.65em;
  }
  .modules-right {
    margin-right: -0.65em;
  }

  #workspaces button {
    background-color: ${colors.surface};
    color: ${colors.on_surface};
    padding-left: 0.4em;
    padding-right: 0.4em;
    margin-top: 0.15em;
    margin-bottom: 0.15em;
  }
  #workspaces button.hidden {
    background-color: ${colors.surface};
    color: ${colors.on_surface_variant};
  }
  #workspaces button.focused,
  #workspaces button.active {
    background-color: ${colors.primary};
    color: ${colors.on_primary};
  }

  #clock {
    padding-right: 1em;
    padding-left: 1em;
    border-radius: 0.5em;
  }
  #custom-menu {
    background-color: ${colors.surface_container};
    color: ${colors.primary};
    padding-right: 1.5em;
    padding-left: 1em;
    margin-right: 0;
    border-radius: 0.5em;
  }
  #custom-menu.fullscreen {
    background-color: ${colors.primary};
    color: ${colors.on_primary};
  }
  #custom-hostname {
    background-color: ${colors.surface_container};
    color: ${colors.primary};
    padding-right: 1em;
    padding-left: 1em;
    margin-left: 0;
    border-radius: 0.5em;
  }
  #custom-currentplayer {
    padding-right: 0;
  }
  #tray {
    color: ${colors.on_surface};
  }
  #custom-gpu, #cpu, #memory {
    margin-left: 0.05em;
    margin-right: 0.55em;
  }
''
