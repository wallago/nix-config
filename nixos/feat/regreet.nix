# Graphical greeter, hooks into greetd
{ pkgs, ... }: {
  programs.regreet = {
    enable = true;
    cageArgs = [ "-s" "-m" "last" ];
    iconTheme = {
      name = "Adwaita";
      package = pkgs.papirus-icon-theme;
    };
    theme = {
      name = "Adwaita";
      package = pkgs.materia-theme;
    };
    font = {
      name = "Fira Sans";
      package = pkgs.fira;
      size = 12;
    };
    cursorTheme = {
      package = pkgs.apple-cursor;
      name = "Adwaita";
    };
  };

  environment.persistence = {
    # Persist last user and last selected session
    "/persist".directories = [{
      directory = "/var/lib/regreet";
      user = "greeter";
      group = "greeter";
    }];
  };
}
