{
  flake.homeModules.nvimPluginConform =
    { pkgs, ... }:
    {
      programs.neovim.plugins = with pkgs.vimPlugins; [
        {
          plugin = conform-nvim;
          config = builtins.readFile ./setup.lua;
        }
      ];

      home.packages = with pkgs; [
        nixfmt
        prettier
        yamlfmt
        rustfmt
        stylua
        sql-formatter
        kulala-fmt
        taplo
        black
        jq
        libxml2
        just
      ];
    };
}
