{ config, ... }:
let
  inherit (config) colorscheme;
  hash = builtins.hashString "md5" (builtins.toJSON colorscheme.colors);
in {
  programs.zellij = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      show_startup_tips = false;
      theme = "nix-${hash}";
      themes."nix-${hash}" = import ./theme.nix { inherit colorscheme; };
      ui = { pane_frames = { rounded_corners = true; }; };
      # https://github.com/zellij-org/zellij/blob/main/zellij-utils/assets/config/default.kdl
      keybinds = {
        # locked = { "bind \"Alt g\"" = { SwitchToMode = "Normal"; }; };
        # normal = { "bind \"Alt g\"" = { "SwitchToMode" = "Locked"; }; };
        "shared_except \"locked\"" = {
          "bind \"Ctrl g\"" = ''{ SwitchToMode = "Locked"; }'';
        };
        shared = {
          # "bind \"Alt p\"" = { "SwitchToMode" = "Pane"; };
          "bind \"Alt t\"" = { "SwitchToMode" = "Tab"; };
          # "bind \"Alt n\"" = { "SwitchToMode" = "Resize"; };
          # "bind \"Alt m\"" = { "SwitchToMode" = "Move"; };
          # "bind \"Alt s\"" = { "SwitchToMode" = "Search"; };
          # "bind \"Alt o\"" = { "SwitchToMode" = "Session"; };
        };
      };
    };
  };
}
#     pane {
#       bind "h" "Left" { MoveFocus "Left"; }
#       bind "l" "Right" { MoveFocus "Right"; }
#       bind "j" "Down" { MoveFocus "Down"; }
#       bind "k" "Up" { MoveFocus "Up"; }
#       bind "p" { SwitchFocus; }
#       bind "Esc" { SwitchToMode "normal"; }
#     }
#   }
# '';
