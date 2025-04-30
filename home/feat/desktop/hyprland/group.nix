{ config, rgba }: {
  "col.border_active" = rgba config.colorscheme.colors.primary "00";
  "col.border_inactive" = rgba config.colorscheme.colors.surface "00";
  groupbar.font_size = 11;
}
