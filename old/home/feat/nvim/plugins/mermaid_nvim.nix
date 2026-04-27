{ pkgs }:
let
  mermaid-vim = pkgs.vimUtils.buildVimPlugin {
    name = "mermaid-nvim";
    src = pkgs.fetchFromGitHub {
      owner = "kevalin";
      repo = "mermaid.nvim";
      rev = "main";
      sha256 = "sha256-10ZetFz98oifqYpZAHib4mpvCL011dUrvc0pmQEN79g=";
    };
  };
in
{
  plugins = [ mermaid-vim ];
  config = ''
    require('mermaid').setup()
  '';
  deps = with pkgs; [
    mermaid-cli
  ];
}
