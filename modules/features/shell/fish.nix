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
      home.packages = with pkgs; [
        libnotify
        fzf
        fd
        bat
        catimg
        viu
        just
        fastfetch
      ];

      programs.fish = {
        enable = true;
        shellAbbrs = {
          j = "just";
        };
        interactiveShellInit = ''
          fish_vi_key_bindings
          set fish_greeting ""
          fzf_configure_bindings --history=

          function clear --description 'clear + header'
            command clear
            if set -q PROJECT_BANNER
              $PROJECT_BANNER
            else if set -q PROJECT_NAME
              __project_banner
            else
              fastfetch --logo small --structure os:kernel:uptime:disk:Memory:Swap:LocalIp
            end
          end

          function __clear_and_repaint
            clear >/dev/tty
            string repeat -N \n --count=(math (count (fish_prompt)) - 1) >/dev/tty
            commandline -f repaint
          end

          function direnv --description 'direnv + banner on reload/allow'
            command direnv $argv
            if contains -- "$argv[1]" reload allow
              clear
            end
          end

          function __auto_fetch --on-variable PWD --description 'background fetch when entering a repo'
            set -l root (jj root 2>/dev/null; or git rev-parse --show-toplevel 2>/dev/null)
            test -n "$root"; or return
            test "$root" = "$__auto_fetch_root"; and return
            set -g __auto_fetch_root $root
            if test -d $root/.jj
              jj -R $root git fetch
            else
              git -C $root fetch --all --prune --quiet
            end
            disown
          end

          __auto_fetch

          bind ctrl-l __clear_and_repaint
          bind -M insert ctrl-l __clear_and_repaint

          bind ctrl-r _atuin_search
          bind -M insert ctrl-r _atuin_search
        '';
        plugins = [
          {
            name = "fzf-fish";
            src = pkgs.fishPlugins.fzf-fish.src;
          }
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
