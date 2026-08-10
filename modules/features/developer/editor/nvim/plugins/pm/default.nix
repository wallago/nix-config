{
  flake.homeModules.nvimPluginPm = { pkgs, ... }: {
    programs.neovim.plugins = [
      {
        plugin = pkgs.runCommandLocal "pm-nvim" { } ''
          mkdir -p $out/lua/pm
          cp ${./setup.lua} $out/lua/pm/init.lua
        '';
        type = "lua";
        config = ''require("pm").setup()'';
      }
    ];
  };
}
