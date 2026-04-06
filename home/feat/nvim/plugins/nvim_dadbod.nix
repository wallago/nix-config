{ pkgs }:
{
  plugins = with pkgs.vimPlugins; [
    vim-dadbod
    vim-dadbod-ui
    vim-dadbod-completion
  ];
  config = ''
    vim.g.db_ui_env_variable_url = 'DATABASE_URL'
    vim.g.db_ui_env_variable_name = 'DATABASE_NAME'
  '';
}
