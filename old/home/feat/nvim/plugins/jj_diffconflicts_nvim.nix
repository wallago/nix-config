{ pkgs }:
let
  jj-diffconflics-nvim = pkgs.vimUtils.buildVimPlugin {
    pname = "jj-diffconflicts";
    version = "unstable";
    src = pkgs.fetchFromGitHub {
      owner = "rafikdraoui";
      repo = "jj-diffconflicts";
      rev = "main";
      hash = "sha256-CDLOo07tGOg/7Sowb1d39k9Nq/RW50axGj8L1D3Be70=";
    };
  };
in
{
  plugins = [ jj-diffconflics-nvim ];
}
