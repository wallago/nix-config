{
  flake.homeModules.claude = { pkgs, ... }: {
    programs.claude-code = {
      enable = true;

      # -> ~/.claude/CLAUDE.md, loaded every session. Keep it brutally short.
      context = ''
        # Environment
        - NixOS. Nothing imperative: no npm -g / cargo install / pip install.
          Add deps to the flake devShell instead.
        - Prefer `just` recipes when the repo has a justfile.
        - CI runs locally via act: `just ci-job`. Don't push to test CI.

        # Git
        - Conventional commits (git-cliff builds the CHANGELOG).
        - Run the repo check recipe before proposing a commit.
      '';

      # Loaded only when the description matches the task.
      skills = {
        nix-module = ./skills/nix-module; # dir with SKILL.md
        release = ./skills/release/SKILL.md; # git-cliff + tag flow
      };

      agents = {
        nix-reviewer = ''
          ---
          name: nix-reviewer
          description: Reviews Nix diffs for correctness, error handling, async pitfalls.
          tools: Read, Grep, Glob, Bash
          ---
          Senior Nix reviewer. Report only gaps affecting correctness or stated
          requirements, not style. Give file:line references.
        '';
      };

      # name -> script content, written to ~/.claude/hooks/<name>
      hooks.fmt-nix = ''
        #!/usr/bin/env bash
        ${pkgs.nixfmt}/bin/nixfmt "$CLAUDE_FILE_PATHS" 2>/dev/null || true
      '';

      settings = {
        permissions = {
          allow = [
            "Bash(just *)"
            "Bash(nix flake check)"
            "Bash(git diff *)"
            "Bash(gh *)"
          ];
          deny = [
            "Bash(nixos-rebuild switch*)"
            "Bash(rm -rf *)"

            # Secrets and key material
            "Read(**/.env)"
            "Read(**/.env.*)"
            "Read(**/*.key)"
            "Read(**/*.pem)"
            "Read(**/*.age)"
            "Read(**/*.sops.*)"
            "Read(**/secrets/**)"
            "Read(**/secrets.yaml)"
            "Read(**/hosts/*/secrets.nix)"
            "Read(**/.ssh/**)"
            "Read(**/id_rsa)"
            "Read(**/id_ed25519)"
            "Read(/persist/**)"
          ];
        };
        hooks.PostToolUse = [
          {
            matcher = "Edit|Write";
            hooks = [
              {
                type = "command";
                command = "$HOME/.claude/hooks/fmt-nix";
              }
            ];
          }
        ];
      };
    };
    # home.file.".claude/settings.json".text = builtins.toJSON {
    #   model = "claude-fable-5";
    #   theme = "dark";
    #   autoUpdates = false;
    #   includeCoAuthoredBy = false;
    #   permissions = {
    #     allow = [
    #       # Git
    #       "Bash(git status*)"
    #       "Bash(git diff*)"
    #       "Bash(git log*)"
    #
    #       # Cmd
    #       "Bash(ls*)"
    #
    #       # Jujutsu
    #       "Bash(jj status*)"
    #       "Bash(jj st*)"
    #       "Bash(jj log*)"
    #       "Bash(jj l*)"
    #       "Bash(jj diff*)"
    #       "Bash(jj show*)"
    #       "Bash(jj op log*)"
    #
    #       # Matches every possible Bash command
    #       "Read(**)"
    #     ];
    #     deny = [
    #       # Secrets and key material
    #       "Read(**/.env)"
    #       "Read(**/.env.*)"
    #       "Read(**/*.key)"
    #       "Read(**/*.pem)"
    #       "Read(**/*.age)"
    #       "Read(**/*.sops.*)"
    #       "Read(**/secrets/**)"
    #       "Read(**/secrets.yaml)"
    #       "Read(**/hosts/*/secrets.nix)"
    #       "Read(**/.ssh/**)"
    #       "Read(**/id_rsa)"
    #       "Read(**/id_ed25519)"
    #       "Read(/persist/**)"
    #
    #       # Mutating git ops
    #       "Bash(git commit*)"
    #       "Bash(git push*)"
    #       "Bash(git checkout*)"
    #       "Bash(git reset*)"
    #
    #       # Mutating jj ops
    #       "Bash(jj git push*)"
    #       "Bash(jj pp*)"
    #
    #       # Optional symmetry with the git deny list (local + reversible via op log):
    #       "Bash(jj describe*)"
    #       "Bash(jj squash*)"
    #       "Bash(jj sq*)"
    #       "Bash(jj amend*)"
    #       "Bash(jj rebase*)"
    #       "Bash(jj sync*)"
    #       "Bash(jj abandon*)"
    #       "Bash(jj edit*)"
    #       "Bash(jj new*)"
    #       "Bash(jj n*)"
    #       "Bash(jj op restore*)"
    #       "Bash(jj undo*)"
    #
    #       # NixOS mutations
    #       "Bash(nixos-rebuild switch*)"
    #       "Bash(nixos-rebuild boot*)"
    #       "Bash(nix profile install*)"
    #       "Bash(nix-env*)"
    #
    #       # Filesystem mutations
    #       "Bash(rm *)"
    #       "Bash(mv *)"
    #     ];
    #   };
    # };
  };
}
