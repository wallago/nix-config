{ self, ... }:
{
  flake.homeModules.terminalEmulator = {
    imports = [ self.homeModules.ghostty ];
  };
}
