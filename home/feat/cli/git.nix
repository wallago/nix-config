{ pkgs, config, ... }: {
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    aliases = {
      p = "pull --ff-only";
      ff = "merge --ff-only";
      graph = "log --decorate --oneline --graph";
      pushall = "!git remote | xargs -L1 git push --all";
    };
    signing = {
      format = "openpgp";
      key = config.yubikey.signing;
      signByDefault = true;
      signer = "${config.programs.gpg.package}/bin/gpg2";
    };
    extraConfig = {
      init.defaultBranch = "main";
      merge.conflictStyle = "zdiff3";
      commit.verbose = true;
      diff.algorithm = "histogram";
      log.date = "iso";
      column.ui = "auto";
      branch.sort = "committerdate";
      # Automatically track remote branch
      push.autoSetupRemote = true;
      pull.ff = "only";
      rebase = {
        autoStash = true;
        autoSquash = true;
      };
      status.showStash = true;
      # Reuse merge conflict fixes when rebasing
      rerere.enabled = true;
    };
    lfs.enable = true;
    ignores = [ ".direnv" "result" ];
    diff-highlight.enable = true;
    hooks = {
      pre-commit = pkgs.writeShellScript "pre-commit-check" ''
        if git diff --check | grep -q '^'; then
          echo "❌ Working directory has whitespace errors."
          exit 1
        fi
        if git diff --cached --check | grep -q '^'; then
          echo "❌ Staged files have whitespace errors."
          exit 1
        fi
      '';
      commit-msg = pkgs.writeShellScript "commit-msg-check" ''
        msg_file="$1"
        msg="$(head -n1 "$msg_file")"

        pattern="^(feat|fix|docs|style|refactor|perf|test|build|ci|chore|revert|wip)(\\([a-z0-9/_-]+\\))?: .+"

        if ! echo "$msg" | grep -qE "$pattern"; then
          echo "❌ Invalid commit message format:"
          echo "→ \"$msg\""
          echo
          echo "Expected Conventional Commit format:"
          echo "  type(scope): description"
          echo
          echo "Valid types: feat, fix, docs, style, refactor, perf, test, build, ci, chore, revert, wip"
          exit 1
        fi
      '';
      pre-push = pkgs.writeShellScript "prevent-force-push" ''
        while read local_ref local_sha remote_ref remote_sha
          do
            if [ "$remote_ref" = "refs/heads/main" ]; then
              # If remote branch does not exist yet (all zeros SHA), allow push
              if [ "$remote_sha" = "0000000000000000000000000000000000000000" ]; then
                # Allow initial push to create the remote branch
                continue
              fi

              if ! git merge-base --is-ancestor "$remote_sha" "$local_sha"; then
                echo "❌ Force push to 'main' is not allowed."
                exit 1
              fi
            fi
          done
      '';
    };
  };

  home.packages = with pkgs; [ git-fixup ];
}
