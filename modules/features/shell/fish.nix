{ self, ... }:
{
  flake.nixosModules.fish = {
    programs.fish = {
      enable = true;
      vendor = {
        completions.enable = true;
        config.enable = true;
        functions.enable = true;
      };
    };
  };

  flake.homeModules.fish =
    { pkgs, ... }:
    {
      imports = [
        self.homeModules.starship
      ];
      home.packages = [ pkgs.libnotify ];

      programs.fish = {
        enable = true;
        interactiveShellInit = ''
          fish_vi_key_bindings
          set fish_greeting ""
        '';
        plugins = [
          {
            name = "colored-man-pages";
            src = pkgs.fishPlugins.colored-man-pages.src;
          }
          {
            name = "done";
            src = pkgs.fishPlugins.done.src;
          }
          {
            name = "foreign-env";
            src = pkgs.fishPlugins.foreign-env.src;
          }
        ];
      };
    };
}
