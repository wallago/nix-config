{ inputs, ... }: {
  flake.homeModules.praline = {
    imports = [ inputs.praline.homeModules.default ];

    programs.praline = {
      enable = true;
      settings = { };
    };
  };
}
