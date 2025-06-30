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
    border: 2px solid ${colors.primary};
    color: ${colors.on_surface};
  }

  .modules-left {
    margin-left: 0em;
  }
  .modules-right {
    margin-right: 0em;
  }

  #workspaces button {
    background-color: ${colors.surface};
    color: ${colors.primary};
    padding-left: 0.4em;
    padding-right: 0.4em;
    margin: 0.6em;
    border: 2px solid ${colors.primary};
  }
  #workspaces button.active {
    background-color: ${colors.primary};
    color: ${colors.on_primary};
  }

  #clock {
    padding-right: 0.4em;
    color: ${colors.primary};
  }
  #custom-os {
    color: ${colors.primary};
    padding-right: 1em;
    border-radius: 0.5em;
  }
  #custom-hostname {
    color: ${colors.primary};
    padding-left: 1em;
    border-radius: 0.5em;
  }
  #tray {
    color: ${colors.on_surface};
  }
  #custom-gpu, 
  #cpu, 
  #memory 
  #custom-currentplayer, 
  #sound, 
  #battery, 
  #custom-tx-net, 
  #custom-rx-net, 
  #network  {
    padding-left: 0.4em;
  }
''
