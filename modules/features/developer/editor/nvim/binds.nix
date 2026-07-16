{
  flake.homeModules.nvimBinds = {
    programs.neovim.initLua = builtins.concatStringsSep "\n" (
      map builtins.readFile [
        ./binds/helpers.lua
        ./binds/layout.lua
        ./binds/windows.lua
        ./binds/tabs.lua
        ./binds/quit-save.lua
        ./binds/which-key.lua
        ./binds/editing.lua
      ]
    );
  };
}
