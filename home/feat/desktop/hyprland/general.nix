{ config, rgba }:
{
  gaps_in = 15;
  gaps_out = 20;
  border_size = 2;
  "col.active_border" = rgba config.colorscheme.colors.primary "aa";
  "col.inactive_border" = rgba config.colorscheme.colors.surface "aa";
}
