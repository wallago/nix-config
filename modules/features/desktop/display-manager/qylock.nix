{ inputs, ... }:
{
  flake.nixosModules.qylock = {
    imports = [ inputs.qylock.nixosModules.default ];

    programs.qylock = {
      enable = true;
      theme = "nier-automata";
      sddm.enable = true;
      quickshell.enable = true;
      themeOptions = {
        terraria.backgroundMode = "time"; # time | random | static
        Genshin.backgroundMode = "time";
        clockwork.orbital = {
          themeMode = "dark";
          enableWindup = true;
        };
        osu.gameMode = "menu"; # menu | game
      };
    };
  };
}
