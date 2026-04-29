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
      home.packages = with pkgs.fishPlugins; [
        colored-man-pages
        done
        foreign-env
        pkgs.libnotify
      ];
      programs.fish = {
        enable = true;
        interactiveShellInit = ''
          set fish_vcs_prompt
          set fish_greeting
        '';
      };
    };
}
