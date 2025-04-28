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
      key = "C6C581A860F158EB";
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
      # Reuse merge conflict fixes when rebasing
      rerere.enabled = true;
    };
    lfs.enable = true;
    ignores = [ ".direnv" "result" ];
    diff-highlight.enable = true;
  };

  home.packages = with pkgs; [ git-fixup ];
}
