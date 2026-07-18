{
  flake.homeModules.nvimBinds = {
    programs.neovim.initLua = builtins.concatStringsSep "\n" (
      map builtins.readFile [
        ./helpers.lua
        ./layout.lua
        ./windows.lua
        ./tabs.lua
        ./quit-save.lua
        ./which-key.lua
        ./editing.lua
        ./buffer.lua
      ]
    );
  };
}
