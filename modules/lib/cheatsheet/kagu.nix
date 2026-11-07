# The Kagu keymap (wallago/kagu), drawn after its keymap/keymap.svg.
#
# A layer is four rows written like the kagu repo's keymap.txt: ten keys,
# ten, ten, then the six thumbs. Cells are separated by two or more spaces.
#
#   TAP         tap label only
#   TAP@HOLD    small HOLD label under the tap label
#   SUB^TAP     small SUB label above the tap label
#   --          blank key
#   ##          the key held to reach this layer
#
# `$$mdi:<name>$$` draws a Material Design icon, as in keymap-drawer.
{ lib, ... }:
let
  shift = "$$mdi:apple-keyboard-shift$$";
  super = "$$mdi:linux$$";
  esc = "$$mdi:keyboard-esc$$";
  ret = "$$mdi:keyboard-return$$";
  bksp = "$$mdi:backspace-outline$$";
  space = "$$mdi:keyboard-space$$";
  tab = "$$mdi:keyboard-tab$$";
  up = "$$mdi:arrow-up$$";
  down = "$$mdi:arrow-down$$";
  left = "$$mdi:arrow-left$$";
  right = "$$mdi:arrow-right$$";
  bt = "$$mdi:bluetooth$$";

  cell =
    c:
    let
      hold = builtins.match "(.+)@(.+)" c;
      sub = builtins.match "(.+)\\^(.+)" c;
    in
    if c == "--" then
      ""
    else if c == "##" then
      { held = true; }
    else if hold != null then
      {
        t = lib.elemAt hold 0;
        h = lib.elemAt hold 1;
      }
    else if sub != null then
      {
        s = lib.elemAt sub 0;
        t = lib.elemAt sub 1;
      }
    else
      c;

  cells = row: lib.filter (c: lib.isString c && c != "") (builtins.split "  +" row);

  keys =
    rows:
    let
      ks = map cell (lib.concatMap cells rows);
    in
    lib.throwIf (
      lib.length ks != 36
    ) "cheatsheet/kagu: a layer needs 36 keys, got ${toString (lib.length ks)}" ks;

  # W+F types Esc and U+Y types Enter, on the layers that keep the letters.
  combos = [
    {
      keys = [
        1
        2
      ];
      k = esc;
    }
    {
      keys = [
        7
        8
      ];
      k = ret;
    }
  ];

  # App and Os share their keys: the hold adds Ctrl or Super to every one.
  modKeys = keys [
    "Q  W  F  P  B         J  ;        ${up}    '         '"
    "A  R  S  T  G         [  ${left}  ${down}  ${right}  ]"
    "Z  X  C  D  V         K  H        ,        .         /"
    "${bksp}  --  --       --  ${space}  --"
  ];

  layers = {
    base = {
      name = "Base";
      subtitle = "Colemak-DH, home row mods";
      accent = "#4a9eff";
      inherit combos;
      keys = keys [
        "Q           W       F           P           B     J  L           U      Y       '"
        "A@${shift}  R@Ctrl  S@Alt       T@${super}  G     M  N@${super}  E@Alt  I@Ctrl  O@${shift}"
        "Z@Sys       X       C@Ctrl+app  D@Super+os  V     K  H@Super+os  ,@Ctrl+app  .  /@Sys"
        "${bksp}@Mou  ${shift}@${shift}  Lwr@Lwr     Rse@Rse  ${space}  Hyp"
      ];
    };

    rse = {
      name = "Rse";
      subtitle = "Numbers and navigation";
      accent = "#a855f7";
      keys = keys [
        "--        7       8      9           --    Home  word^$$mdi:arrow-collapse-left$$  ${up}  word^$$mdi:arrow-collapse-right$$  End"
        "${shift}  4@Ctrl  5@Alt  6@${super}  --    back^$$mdi:arrow-u-left-top$$  ${left}  ${down}  ${right}  fwd^$$mdi:arrow-u-right-top$$"
        "0         1       2      3           --    prev tab^$$mdi:tab-minus$$  ✦ [  ✦ \\  ✦ ]  next tab^$$mdi:tab-plus$$"
        "${esc}  --  ${ret}    ##  --  --"
      ];
    };

    lwr = {
      name = "Lwr";
      subtitle = "Symbols";
      accent = "#f59e0b";
      keys = keys [
        "~             ^       @      $           %     &  /           \\     |       `"
        "${esc}@${shift}  <@Ctrl  [@Alt  (@${super}  {     -  _@${super}  :@Alt  ;@Ctrl  #@${shift}"
        "--            >       ]      )           }     +  =           ?      !       \""
        "--  --  ##    $$mdi:keyboard-tab-reverse$$  ${tab}  --"
      ];
    };

    mou = {
      name = "Mou";
      subtitle = "Left-hand shortcuts, right hand on the mouse";
      accent = "#06b6d4";
      keys = keys [
        "Ctl Q  Ctl W  --     --     --       --  --  --  --  --"
        "--     --     Ctl S  Ctl T  --       --  --  --  --  --"
        "Ctl Z  Ctl X  Ctl C  --     Ctl V    --  --  --  --  --"
        "##  --  --    --  --  --"
      ];
    };

    app = {
      name = "App";
      subtitle = "Hold C or , : every key is sent with Ctrl";
      accent = "#22c55e";
      inherit combos;
      keys = modKeys;
    };

    os = {
      name = "Os";
      subtitle = "Hold D or H : every key is sent with Super";
      accent = "#14b8a6";
      inherit combos;
      keys = modKeys;
    };

    hyp = {
      name = "Hyp";
      subtitle = "Ctrl+Alt+Shift+Super (✦), for niri";
      accent = "#f43f5e";
      keys = keys [
        "✦ Q  ✦ W  ✦ F  ✦ P  ✦ B     ✦ 1  ✦ 2        ✦ 3        ✦ 4         ✦ 5"
        "✦ A  ✦ R  ✦ S  ✦ T  ✦ G     --   ✦ ${left}  ✦ ${up}    ✦ ${right}  --"
        "✦ Z  ✦ X  ✦ C  ✦ D  ✦ V     --   ✦ ;        ✦ ${down}  ✦ '         --"
        "✦ ${esc}  --  ✦ ${tab}      ✦ ${ret}  ✦ ${space}  ##"
      ];
    };

    sys = {
      name = "Sys";
      subtitle = "Bluetooth profiles, hold Z or /";
      accent = "#8b5cf6";
      keys = keys [
        "0^${bt}  1^${bt}  2^${bt}  --  --    --  --  --  --  --"
        "clear^$$mdi:bluetooth-off$$  --  --  --  --    --  --  --  --  --"
        "##  --  --  --  --    --  --  --  --  --"
        "--  --  --    --  --  --"
      ];
    };
  };

  page = order: subtitle: names: _: {
    inherit order subtitle;
    title = "Kagu";
    inherit (layers.${lib.head names}) accent;
    footer = "Big label: tap. Small label below: hold. Filled key: the hold that opened the layer.";
    legend = [
      {
        key = "W F";
        label = "Esc";
      }
      {
        key = "U Y";
        label = "Enter";
      }
    ];
    layers = map (n: layers.${n}) names;
  };
in
{
  flake.lib.cheatsheets = {
    kagu-typing = page 1 "Typing layers" [
      "base"
      "rse"
      "lwr"
      "mou"
    ];
    kagu-holds = page 2 "Modifier layers" [
      "app"
      "os"
      "hyp"
      "sys"
    ];
  };
}
