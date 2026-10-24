{
  flake.homeModules.nvimPluginLsp =
    { pkgs, ... }:
    {
      programs.neovim.plugins = with pkgs.vimPlugins; [
        {
          plugin = nvim-lspconfig;
          config = builtins.concatStringsSep "\n" (
            map builtins.readFile [
              ./binds.lua
              ./harper.lua
              ./just.lua
              ./nix.lua
              ./diagnostic.lua
              ./common.lua
              ./slint.lua
            ]
          );
        }
      ];

      home.packages = with pkgs; [
        nixd
        nixfmt
        manix
        just-lsp
        harper
      ];
    };
}
