{ pkgs }:
{
  plugins = with pkgs.vimPlugins; [
    kulala-nvim
  ];
  config = ''
    require("kulala").setup({})
  '';
  deps = with pkgs; [
    curl
    grpcurl
    websocat
    jq
    openssl
  ];
}
