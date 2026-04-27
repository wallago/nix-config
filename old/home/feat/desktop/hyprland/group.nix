{ config, rgba }: {
  "col.border_active" = rgba config.colorscheme.colors.primary "FF";
  "col.border_inactive" = rgba config.colorscheme.colors.surface "FF";
  groupbar.font_size = 11;
}
