{
  flake.homeModules.ai = {
    home.file."chat/CLAUDE.md".text = ''
      This is a general conversation space, not a code project.
      Answer conversationally and concisely. Don't scan files or run
      commands unless I ask. Web search is fine when facts may be current.
    '';

    programs.fish.shellAliases = {
      chat = "env -C ~/chat claude";
      chatc = "env -C ~/chat claude -c";
      chatr = "env -C ~/chat claude -r";
    };
  };
}
