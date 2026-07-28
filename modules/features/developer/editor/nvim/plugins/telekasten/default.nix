{
  flake.homeModules.nvimPluginTelekasten =
    { pkgs, ... }:
    let
      home = "~/sync-notes";
    in
    {
      programs.neovim.plugins = with pkgs.vimPlugins; [
        mattn-calendar-vim
        {
          plugin = telekasten-nvim;
          config = builtins.concatStringsSep "\n" [
            ''
              require("telekasten").setup({
              	home = vim.fn.expand("${home}"),
              	auto_set_filetype = false,
              	auto_set_syntax = true,
              	dailies = vim.fn.expand("${home}/daily"),
              	weeklies = vim.fn.expand("${home}/weekly"),
              	templates = vim.fn.expand("${home}/templates"),
              	template_new_daily = vim.fn.expand("${home}/templates/template_new_daily.md"),
              	template_new_weekly = vim.fn.expand("${home}/templates/template_new_weekly.md"),
              })
            ''
            (builtins.readFile ./binds.lua)
          ];
        }
      ];
    };
}
