{ pkgs }:
{
  plugins = with pkgs.vimPlugins; [ yanky-nvim ];
  config = ''
    require("yanky").setup({
      ring = {
        history_length = 100,
        storage = "shada",
        sync_with_numbered_registers = true,
        cancel_event = "update",
        ignore_registers = { "_" },
        update_register_on_cycle = false,
        permanent_wrapper = nil,
      },
      system_clipboard = {
        sync_with_ring = true,
      },
    })
  '';
}
