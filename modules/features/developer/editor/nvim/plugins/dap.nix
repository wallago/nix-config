{
  flake.homeModules.nvimPluginDap =
    { pkgs, ... }:
    {
      programs.neovim.plugins = with pkgs.vimPlugins; [
        nvim-nio
        {
          plugin = nvim-dap;
          config = ''
            local dap = require("dap")

            map("n", "<leader>db", dap.toggle_breakpoint, { desc = "DAP: toggle breakpoint" })
            map("n", "<leader>dB", function()
              dap.set_breakpoint(vim.fn.input("Condition: "))
            end, { desc = "DAP: conditional breakpoint" })
            map("n", "<leader>dc", dap.continue,  { desc = "DAP: continue / start" })
            map("n", "<leader>di", dap.step_into, { desc = "DAP: step into" })
            map("n", "<leader>do", dap.step_over, { desc = "DAP: step over" })
            map("n", "<leader>dO", dap.step_out,  { desc = "DAP: step out" })
            map("n", "<leader>dr", dap.repl.toggle, { desc = "DAP: toggle REPL" })
            map("n", "<leader>dl", dap.run_last,  { desc = "DAP: run last" })
            map("n", "<leader>dt", dap.terminate, { desc = "DAP: terminate" })

            vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError" })
            vim.fn.sign_define("DapStopped",    { text = "▶", texthl = "DiagnosticWarn", linehl = "Visual" })
          '';
        }
        {
          plugin = nvim-dap-ui;
          config = ''
            local dap, dapui = require("dap"), require("dapui")
            dapui.setup()
            dap.listeners.before.attach.dapui_config           = function() dapui.open() end
            dap.listeners.before.launch.dapui_config           = function() dapui.open() end
            dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
            dap.listeners.before.event_exited.dapui_config     = function() dapui.close() end

            map("n", "<leader>du", dapui.toggle, { desc = "DAP: toggle UI" })
            map({ "n", "v" }, "<leader>de", dapui.eval, { desc = "DAP: eval" })
          '';
        }
      ];
    };
}
