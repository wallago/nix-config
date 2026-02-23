{
  lib,
  config,
  pkgs,
  ...
}:
{
  programs.fish = {
    enable = true;
    functions = {
      fish_jj_prompt = {
        description = "Jujutsu prompt";
        body = ''
          if not command -sq jj
            return 1
          end
          set -l info "$(
            jj log 2>/dev/null --no-graph --ignore-working-copy --color=always --revisions @ \
              --template '
                surround(
                  "(",
                  ")",
                  separate(
                    " ",
                    bookmarks.join(", "),
                    change_id.shortest(),
                    commit_id.shortest(),
                    if(conflict, label("conflict", "×")),
                    if(divergent, label("divergent", "??")),
                    if(hidden, label("hidden prefix", "(hidden)")),
                    if(immutable, label("node immutable", "◆")),
                    coalesce(
                      if(
                        empty,
                        coalesce(
                          if(
                            parents.len() > 1,
                            label("empty", "(merged)"),
                            ),
                          label("empty", "(empty)"),
                          ),
                        ),
                      label("description placeholder", "*")
                      ),
                    )
                  )
                '
          )"
          or return 1
          if test -n "$info"
            printf ' %s' $info
          end
        '';
      };
      fish_prompt = {
        body = ''
          set -l last_status $status

          # 1. VI-Mode Indicator (I/N/V)
          switch $fish_bind_mode
              case default
                  set_color --bold red
                  echo -n "N "
              case insert
                  set_color --bold cyan
                  echo -n "I "
              case visual
                  set_color --bold magenta
                  echo -n "V "
          end

          # 2. Directory (Blue and Bold)
          set_color --bold blue
          echo -n (prompt_pwd)
          set_color normal

          # 3. Jujutsu / VCS Status
          fish_jj_prompt
          or fish_git_prompt

          # 4. The Final Symbol (Green if success, Red if error)
          if test $last_status -eq 0
              set_color green
          else
              set_color red
          end
          echo -n " ❱ "
          set_color normal
        '';
      };
    };
    interactiveShellInit = ''
      fish_vi_key_bindings
      function fish_mode_prompt; end


      # set -g __fish_git_prompt_showdirtyState 1
      # set -g __fish_git_prompt_showuntrackedfiles 1
      # set -g __fish_git_prompt_showstashstate 1
      # set -g __fish_git_prompt_showupstream auto
      # set -g __fish_git_prompt_color_branch yellow
      # set -g __fish_git_prompt_char_dirtystate '*'
      # set -g __fish_git_prompt_char_untrackedfiles '?'

      set fish_cursor_default     block      blink
      set fish_cursor_insert      line       blink
      set fish_cursor_replace_one underscore blink
      set fish_cursor_visual      block

      if test -z "$ZELLIJ"
        zellij -l monitor
      end
    '';
    shellAliases = {
      # List directory contents
      l = lib.mkIf config.programs.eza.enable "eza -lah";
      ls = lib.mkIf config.programs.eza.enable "eza";
      tree = lib.mkIf config.programs.eza.enable "eza --tree --git-ignore";

      # Utilities
      cat = lib.mkIf config.programs.bat.enable "bat";
      top = lib.mkIf config.programs.bottom.enable "btm";
      man = lib.mkIf config.programs.bat.enable "batman";
      watch = lib.mkIf config.programs.bat.enable "batwatch";
      less = lib.mkIf config.programs.bat.enable "batpipe";
      grep = lib.mkIf config.programs.ripgrep.enable "rg";
      logout = lib.mkIf config.wayland.windowManager.hyprland.enable "hyprctl dispatch exit";

      # Misc
      c = "printf '\\033[2J\\033[3J\\033[1;1H'";
      h = "history";
      cdp = "pwd | xclip -selection clipboard";
      ports = "netstat -tulamp";
      j = "just";
      mail-refresher = "mbsync -a -V";
      gpg-keys = "gpg --list-keys";

      # NixOS system management
      ns = "sudo nixos-rebuild switch --flake ";
      nb = "sudo nixos-rebuild build --flake ";
      ndb = "sudo nixos-rebuild dry-build --flake ";
      nfu = "nix flake update";
      npu = "nix-prefetch-url";
      ncg = "sudo nix-collect-garbage -d";
      ns-fix = "nix-store --verify --check-contents --repair";
      find-ns = "find /nix/store -name";
    };
  };

  home.packages = with pkgs; [
    fishPlugins.fzf
    # fishPlugins.hydro
    nettools
  ];
}
