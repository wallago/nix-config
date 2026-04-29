{
  flake.homeModules.nvim = {

    programs.neovim = {
      enable = true;
      viAlias = true;
      defaultEditor = true;
    };
  };
}
