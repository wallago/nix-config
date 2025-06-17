{ inputs, pkgs, config, ... }: {
  home.persistence = {
    "/persist/${config.home.homeDirectory}".directories = [ "Perso/" "Work/" ];
  };

  programs.git = {
    userName = "wallago";
    userEmail = "45556867+wallago@users.noreply.github.com";
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
