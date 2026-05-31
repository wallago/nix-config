{
  flake.homeModules.nvimPluginAutopairs =
    { pkgs, ... }:
    {
      programs.neovim.plugins = with pkgs.vimPlugins; [
        {
          plugin = nvim-autopairs;
          config = ''
            require("nvim-autopairs").setup({
              check_ts = true,      -- use treesitter to avoid pairing in strings/comments
              ts_config = {
                lua = { "string" }, -- don't add pairs inside lua strings
              },
              fast_wrap = {},       -- <M-e> to wrap existing text in a pair
            })
          '';
        }
      ];
    };
}
