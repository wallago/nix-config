{ inputs, pkgs, ... }:
{
  home.persistence = {
    "/persist/".directories = [
      "Perso/"
      "Work/"
      "Team/"
    ];
  };

  programs.git = {
    settings.user.name = "wallago";
    settings.user.email = "45556867+wallago@users.noreply.github.com";
  };

  programs.firefox.profiles.wallago = {
    extensions.packages = with inputs.firefox-addons.packages.${pkgs.system}; [
      ublock-origin
      browserpass
      vimium
      privacy-badger
      new-tab-override
    ];
  };
}
