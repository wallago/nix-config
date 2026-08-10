{
  flake.homeModules.gh = {
    programs.gh = {
      enable = true;
      settings = {
        git_protocol = "ssh";
        prompt = "enabled";
        editor = "vi";
        aliases = {
          # PRs
          pv = "pr view";
          pl = "pr list";
          pd = "pr diff";
          pc = "pr create --fill";
          pk = "pr checks";

          # Actions — you have 4 workflows, this is where the typing is
          rl = "run list -L 10";
          rw = "run watch";
          rf = "run view --log-failed";
          rr = "run rerun --failed";

          # Issues
          il = "issue list";
          iv = "issue view";

          # runs for the branch you're actually on
          ci = "!gh run list --branch $(git branch --show-current) -L 5";

          # Repo
          # Example: gh init this-is-the-repo-name --public -d "This is a desc."
          init = ''
            !set -e
            git init -b main
            git add -A
            git commit -m "chore: initial commit"
            gh repo create "$@" --source=. --push'';
        };
      };
    };
  };
}
