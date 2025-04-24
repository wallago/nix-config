{ colorscheme }:
let c = colorscheme.colors;
in {
  ribbon_unselected = {
    base = c.on_surface;
    background = c.surface_container_high;
    emphasis_0 = c.primary;
    emphasis_1 = "#0000FF";
    emphasis_2 = "#0000FF";
    emphasis_3 = "#0000FF";
  };

  ribbon_selected = {
    base = c.surface;
    background = c.primary;
    emphasis_0 = c.on_primary;
    emphasis_1 = "#FF0000";
    emphasis_2 = "#FF0000";
    emphasis_3 = "#FF0000";
  };

  frame_selected = {
    base = c.primary;
    background = "#FF00FF";
    emphasis_0 = "#FF00FF";
    emphasis_1 = "#FF00FF";
    emphasis_2 = "#FF00FF";
    emphasis_3 = "#FF00FF";
  };

  frame_unselected = {
    base = c.on_surface;
    background = "#FF00FF";
    emphasis_0 = "#FF00FF";
    emphasis_1 = "#FF00FF";
    emphasis_2 = "#FF00FF";
    emphasis_3 = "#FF00FF";
  };

  frame_highlight = {
    base = c.cyan;
    background = "#FF00FF";
    emphasis_0 = "#FF00FF";
    emphasis_1 = "#FF00FF";
    emphasis_2 = "#FF00FF";
    emphasis_3 = "#FF00FF";
  };

  exit_code_success = {
    base = c.green;
    background = "#FF00FF";
    emphasis_0 = "#FF00FF";
    emphasis_1 = "#FF00FF";
    emphasis_2 = "#FF00FF";
    emphasis_3 = "#FF00FF";
  };

  exit_code_error = {
    base = c.red;
    background = "#FF00FF";
    emphasis_0 = "#FF00FF";
    emphasis_1 = "#FF00FF";
    emphasis_2 = "#FF00FF";
    emphasis_3 = "#FF00FF";
  };

  text_unselected = {
    base = c.on_surface;
    background = c.surface;
    emphasis_0 = c.primary;
    emphasis_1 = "#FFFF00";
    emphasis_2 = c.primary;
    emphasis_3 = "#FFFF00";
  };
}
