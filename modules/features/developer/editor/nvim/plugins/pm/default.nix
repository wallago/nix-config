{
  flake.homeModules.nvimPluginPm = { pkgs, ... }: {
    programs.neovim.plugins = [
      {
        plugin = pkgs.runCommandLocal "pm-nvim" { } ''
          mkdir -p $out/lua
          cp -r ${./lua}/. $out/lua/
        '';
        type = "lua";
        config = ''require("pm").setup()'';
      }
    ];
  };
}
