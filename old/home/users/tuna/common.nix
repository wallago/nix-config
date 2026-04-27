{ inputs, pkgs, ... }:
{
  home.persistence = {
    "/persist/".directories = [
      "Work/"
    ];
  };

  programs.git = {
    settings.user.name = "wallago";
    settings.user.email = "45556867+wallago@users.noreply.github.com";
  };
}
