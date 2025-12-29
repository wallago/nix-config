{ keymap, config, ... }:
let
  inherit (config) colorscheme;
  hash = builtins.hashString "md5" (builtins.toJSON colorscheme.colors);
  nav = keymap.nav;
in {
  programs.zellij = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      show_startup_tips = false;
      theme = "nix-${hash}";
      themes."nix-${hash}" = import ./theme.nix { inherit colorscheme; };
      ui = { pane_frames = { rounded_corners = true; }; };
      # NOTE: https://github.com/zellij-org/zellij/blob/main/zellij-utils/assets/config/default.kdl
      keybinds = {
        "shared_except \"pane\" \"locked\"" = {
          "unbind" = "Ctrl p";
          "bind \"Alt p\"" = { SwitchToMode = "Pane"; };
        };
        "shared_except \"resize\" \"locked\"" = {
          "unbind" = "Ctrl r";
          "bind \"Alt r\"" = { SwitchToMode = "Resize"; };
        };
        "shared_except \"scroll\" \"locked\"" = {
          "unbind" = "Ctrl s";
          "bind \"Alt s\"" = { SwitchToMode = "Scroll"; };
        };
        "shared_except \"session\" \"locked\"" = {
          "unbind" = "Ctrl o";
          "bind \"Alt c\"" = { SwitchToMode = "Session"; };
        };
        "shared_except \"tab\" \"locked\"" = {
          "unbind" = "Ctrl t";
          "bind \"Alt t\"" = { SwitchToMode = "Tab"; };
        };
        "shared_except \"move\" \"locked\"" = {
          "unbind" = "Ctrl h";
          "bind \"Alt m\"" = { SwitchToMode = "Move"; };
        };
        "shared_except \"tmux\" \"locked\"" = {
          "unbind" = "Ctrl b";
          "bind \"Alt b\"" = { SwitchToMode = "Tmux"; };
        };
        "shared_except \"locked\"" = {
          "unbind" = [ "Ctrl g" "Ctrl q" ];
          "bind \"Alt g\"" = { SwitchToMode = "Locked"; };
          "bind \"Alt q\"" = { Quit = { }; };
          "bind \"Alt f\"" = { ToggleFloatingPanes = { }; };
          "bind \"Alt y\"" = { MoveTab = "Left"; };
          "bind \"Alt u\"" = { MoveTab = "Right"; };
          "bind \"Alt ${nav.left}\"" = { MoveFocusOrTab = "Left"; };
          "bind \"Alt ${nav.right}\"" = { MoveFocusOrTab = "Right"; };
          "bind \"Alt ${nav.down}\"" = { MoveFocus = "Down"; };
          "bind \"Alt ${nav.up}\"" = { MoveFocus = "Up"; };
          "bind \"Alt =\" \"Alt +\"" = { Resize = "Increase"; };
          "bind \"Alt -\"" = { Resize = "Decrease"; };
        };
        locked = {
          "unbind" = "Ctrl g";
          "bind \"Alt g\"" = { SwitchToMode = "Normal"; };
        };
        resize = {
          "unbind" = "Ctrl r";
          "bind \"Alt r\"" = { SwitchToMode = "Normal"; };
        };
        pane = {
          "unbind" = "Ctrl p";
          "bind \"Alt p\"" = { SwitchToMode = "Normal"; };
        };
        renamepane = {
          "unbind" = "Ctrl c";
          "bind \"Alt c\"" = { SwitchToMode = "Normal"; };
        };
        move = {
          "unbind" = "Ctrl h";
          "bind \"Alt h\"" = { SwitchToMode = "Normal"; };
        };
        tab = {
          "unbind" = "Ctrl t";
          "bind \"Alt t\"" = { SwitchToMode = "Normal"; };
        };
        renametab = {
          "unbind" = "Ctrl c";
          "bind \"Alt c\"" = { SwitchToMode = "Normal"; };
        };
        scroll = {
          "unbind" = [ "Ctrl s" "Ctrl c" ];
          "bind \"Alt s\"" = { ScrollToBottom = { }; };
          "bind \"Alt s\"" = { SwitchToMode = "Normal"; };
        };
        search = {
          "unbind" = [ "Ctrl s" "Ctrl c" ];
          "bind \"Alt s\"" = { ScrollToBottom = { }; };
          "bind \"Alt c\"" = { SwitchToMode = "Normal"; };
        };
        entersearch = {
          "unbind" = "Ctrl c";
          "bind \"Alt c\"" = { SwitchToMode = "Scroll"; };
        };
        session = {
          "unbind" = [ "Ctrl o" "Ctrl s" ];
          "bind \"Alt o\"" = { SwitchToMode = "Normal"; };
          "bind \"Alt s\"" = { SwitchToMode = "Scroll"; };
        };
        tmux = {
          "unbind" = "Ctrl b";
          "bind \"Alt b\"" = {
            Write = 2;
            SwitchToMode = "Normal";
          };
        };
      };
    };
  };
}
