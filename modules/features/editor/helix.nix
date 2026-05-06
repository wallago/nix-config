{
  flake.homeModules.helix = {
    programs.helix = {
      enable = true;
      ignores = [
        ".build/"
        "!.gitignore"
      ];
      settings = {
        theme = "base16";
        editor = {
          line-number = "relative";
          lsp.display-messages = true;
        };
        keys.normal = {
          space.space = "file_picker";
          space.w = ":w";
          space.q = ":q";
          esc = [
            "collapse_selection"
            "keep_primary_selection"
          ];
        };
      };
      languages = {
        language = [
          {
            name = "rust";
            auto-format = false;
          }
        ];
      };
      defaultEditor = true;
    };
  };
}
