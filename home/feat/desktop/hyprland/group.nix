{ config, rgba }:
{
  "col.border_active" = rgba config.colorscheme.colors.primary "aa";
  "col.border_inactive" = rgba config.colorscheme.colors.surface "aa";
  groupbar.font_size = 11;
}
