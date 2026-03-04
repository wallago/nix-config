{ pkgs }:
{
  plugins = with pkgs.vimPlugins; [
    neovim-tips
    markview-nvim
  ];
  config = ''
    require("neovim_tips").setup({
      user_file = vim.fn.stdpath("config") .. "/neovim_tips/user_tips.md",
      user_tip_prefix = "[User] ",
      warn_on_conflicts = true,
      -- Daily tip mode: 0=off, 1=once per day, 2=every startup
      daily_tip = 1,
    })
  '';
}
