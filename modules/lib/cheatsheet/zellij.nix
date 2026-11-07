_: {
  flake.lib.cheatsheets.zellij =
    _:
    let
      row = mods: key: title: { inherit mods key title; };
    in
    {
      order = 2;

      title = "Zellij";
      subtitle = "Terminal Sessions";
      footer = "zj in a project dir attaches or creates its session. Esc goes back to Normal, Ctrl g locks again.";

      legend = [
        {
          key = "ALT";
          label = "works even when locked";
        }
        {
          key = "^G";
          label = "Ctrl g, unlocks the modes";
        }
      ];

      cards = [
        {
          label = "Anywhere";
          subtitle = "Always on, even in locked mode";
          accent = "#4a9eff";
          icon = 61724;
          rows = [
            (row [ "Alt" ] "N" "Focus left, or previous tab")
            (row [ "Alt" ] "E" "Focus down")
            (row [ "Alt" ] "I" "Focus up")
            (row [ "Alt" ] "O" "Focus right, or next tab")
            (row [ "Alt" ] "A" "New pane")
            (row [ "Ctrl" ] "G" "Unlock / lock zellij")
          ];
        }
        {
          label = "Modes";
          subtitle = "After Ctrl g, pick a mode";
          accent = "#f59e0b";
          icon = 61641;
          rows = [
            (row [ "Ctrl" ] "P" "Pane")
            (row [ "Ctrl" ] "T" "Tab")
            (row [ "Ctrl" ] "N" "Resize")
            (row [ "Ctrl" ] "H" "Move")
            (row [ "Ctrl" ] "S" "Scroll")
            (row [ "Ctrl" ] "O" "Session")
            (row [ "Ctrl" ] "Q" "Quit and kill the session")
          ];
        }
        {
          label = "Pane";
          subtitle = "Ctrl g, Ctrl p, then";
          accent = "#a855f7";
          icon = 62162;
          rows = [
            (row [ ] "N E I O" "Focus left, down, up, right")
            (row [ ] "A" "New pane")
            (row [ ] "D / R" "New pane below / right")
            (row [ ] "X" "Close pane")
            (row [ ] "F" "Fullscreen")
            (row [ ] "W" "Show / hide floating panes")
            (row [ ] "B" "Embed / float this pane")
            (row [ ] "C" "Rename pane")
          ];
        }
        {
          label = "Tab";
          subtitle = "Ctrl g, Ctrl t, then";
          accent = "#22c55e";
          icon = 61449;
          rows = [
            (row [ ] "N / O" "Previous / next tab")
            (row [ ] "1-9" "Go to tab")
            (row [ ] "TAB" "Last tab")
            (row [ ] "A" "New tab")
            (row [ ] "X" "Close tab")
            (row [ ] "R" "Rename tab")
            (row [ ] "B" "Break pane into a new tab")
          ];
        }
        {
          label = "Resize and move";
          subtitle = "Ctrl g, then Ctrl n or Ctrl h";
          accent = "#06b6d4";
          icon = 61511;
          rows = [
            (row [ ] "N E I O" "Resize: grow that way")
            (row [ "Shift" ] "N E I O" "Resize: shrink that way")
            (row [ ] "= / -" "Resize: grow / shrink all")
            (row [ ] "N E I O" "Move: swap pane that way")
            (row [ ] "TAB" "Move: to next slot")
          ];
        }
        {
          label = "Scroll and session";
          subtitle = "Ctrl g, then Ctrl s or Ctrl o";
          accent = "#f43f5e";
          icon = 61442;
          rows = [
            (row [ ] "E / I" "Scroll: line down / up")
            (row [ ] "D / U" "Scroll: half page down / up")
            (row [ ] "S" "Scroll: search")
            (row [ ] "H" "Search: next match, Shift for previous")
            (row [ ] "V" "Scroll: open in editor")
            (row [ ] "W" "Session: switch session")
            (row [ ] "D" "Session: detach")
          ];
        }
      ];
    };
}
