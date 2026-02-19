{ keymap }:
let
  layout = keymap.kb.layout;
  variant = keymap.kb.variant;
in
{
  kb_layout = layout;
  kb_variant = variant;
  touchpad.disable_while_typing = false;
  resolve_binds_by_sym = 1;
}
