{
  flake.homeModules.nvimPluginCommentFrame =
    { pkgs, ... }:
    let
      nvim-comment-frame = pkgs.vimUtils.buildVimPlugin {
        pname = "nvim-comment-frame";
        version = "0-unstable-2025-08-05";
        src = pkgs.fetchFromGitHub {
          owner = "s1n7ax";
          repo = "nvim-comment-frame";
          rev = "5719db5d3b15b451f89db409ce9164a716ecbef6";
          hash = "sha256-xrbQe0zp79K2GYtN3Pi96xywQEfIPjfPLZGscUXq1z0=";
        };
        dependencies = [ pkgs.vimPlugins.nvim-treesitter ];
      };
    in
    {
      programs.neovim.plugins = [
        {
          plugin = nvim-comment-frame;
          config = builtins.readFile ./setup.lua;
        }
      ];
    };
}
