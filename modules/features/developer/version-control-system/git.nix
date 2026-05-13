{
  flake.homeModules.git = {
    programs.git = {
      enable = true;
      settings.user = {
        name = "wallago";
        email = "45556867+wallago@users.noreply.github.com";
      };
    };
  };
}
