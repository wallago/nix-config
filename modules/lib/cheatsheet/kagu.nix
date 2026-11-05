_: {
  flake.lib.cheatsheets.kagu =
    _:
    let
      row = mods: key: title: { inherit mods key title; };
    in
    {
      order = 1;

      title = "Kagu";
      subtitle = "Keyboard Layers";
      footer = "Not mapped yet: ; and :. Mods share keys with letters, so no Ctrl s, Ctrl t, Alt r, Gui a.";

      legend = [
        {
          key = "NAV";
          label = "hold left middle thumb";
        }
        {
          key = "SYM";
          label = "hold right middle thumb";
        }
      ];

      cards = [
        {
          label = "Thumbs";
          subtitle = "Left to right, outer to inner";
          accent = "#4a9eff";
          icon = 61724;
          rows = [
            (row [ ] "ESC" "Left outer")
            (row [ ] "NAV" "Left middle, hold")
            (row [ ] "SPACE" "Left inner")
            (row [ ] "SHIFT" "Right inner")
            (row [ ] "SYM" "Right middle, hold")
            (row [ ] "BKSP" "Right outer")
            (row [ "NAV" ] "SYM" "Hold both: system layer")
          ];
        }
        {
          label = "Editing";
          subtitle = "Keys that left the base layer";
          accent = "#06b6d4";
          icon = 61728;
          rows = [
            (row [ "NAV" ] "F" "Enter")
            (row [ "NAV" ] "Q" "Tab")
            (row [ "SHIFT" "NAV" ] "Q" "Shift Tab")
            (row [ "NAV" ] "W" "Esc")
            (row [ "NAV" ] "P" "Delete")
            (row [ "NAV" ] "B" "Caps lock")
            (row [ "NAV" ] "'" "Insert")
          ];
        }
        {
          label = "Arrows";
          subtitle = "Inverted T on the right hand";
          accent = "#a855f7";
          icon = 61618;
          rows = [
            (row [ "NAV" ] "U" "Up")
            (row [ "NAV" ] "N" "Left")
            (row [ "NAV" ] "E" "Down")
            (row [ "NAV" ] "I" "Right")
            (row [ "NAV" ] "L" "Home")
            (row [ "NAV" ] "Y" "End")
            (row [ "NAV" ] "J" "Page up")
            (row [ "NAV" ] "M" "Page down")
          ];
        }
        {
          label = "Modifiers";
          subtitle = "Hold on Nav, release Nav, keep holding";
          accent = "#22c55e";
          icon = 61449;
          rows = [
            (row [ "NAV" ] "A" "Gui")
            (row [ "NAV" ] "R" "Alt")
            (row [ "NAV" ] "S" "Ctrl")
            (row [ "NAV" ] "T" "Shift")
            (row [ "NAV" "S" ] "C" "Ctrl c: drop Nav, keep S, tap C")
            (row [ "NAV" "S" ] "N" "Word left (Nav still held)")
            (row [ "NAV" "S" ] "I" "Word right (Nav still held)")
          ];
        }
        {
          label = "Symbols";
          subtitle = "Top row is digits, middle row is shifted digits";
          accent = "#f59e0b";
          icon = 61729;
          rows = [
            (row [ "SYM" ] "H" "(")
            (row [ "SYM" ] "," ")")
            (row [ "SYM" ] "." "[")
            (row [ "SYM" ] "/" "]")
            (row [ "SHIFT" "SYM" ] "." "{")
            (row [ "SHIFT" "SYM" ] "/" "}")
            (row [ "SYM" ] "I" "-")
            (row [ "SYM" ] "O" "=")
            (row [ "SYM" ] "K" "|")
            (row [ "SHIFT" ] "'" "\"")
          ];
        }
        {
          label = "System";
          subtitle = "Hold Nav and Sym together";
          accent = "#f43f5e";
          icon = 61459;
          rows = [
            (row [ "NAV" "SYM" ] "Q" "Bluetooth 0 (W F P B: 1 to 4)")
            (row [ "NAV" "SYM" ] "A" "Toggle USB / Bluetooth")
            (row [ "NAV" "SYM" ] "Z" "Forget current host")
            (row [ "NAV" "SYM" ] "X" "Forget all hosts")
            (row [ "NAV" "SYM" ] "O" "Reset")
            (row [ "NAV" "SYM" ] "'" "Bootloader")
          ];
        }
      ];
    };
}
