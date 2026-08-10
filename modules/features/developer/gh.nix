{
  flake.homeModules.gh = {
    programs.gh = {
      enable = true;
      settings = {
        git_protocol = "ssh";
        prompt = "enabled";
        editor = "vi";
        aliases = {
          co = "pr checkout";
          pv = "pr view";
        };
      };
    };
  };
}
