{ pkgs }:
let
  mermaid-vim = pkgs.vimUtils.buildVimPlugin {
    name = "mermaid-vim";
    src = pkgs.fetchFromGitHub {
      owner = "mracos";
      repo = "mermaid.vim";
      rev = "main";
      sha256 = "sha256-LRuuCFamwvBm9e5mbQ8CkGgclEY9iv52uRl/2kGBUc8=";
    };
    meta.homepage = "https://github.com/mracos/mermaid.vim";
  };
in
{
  plugins = [ mermaid-vim ];
}
