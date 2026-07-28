local dapui = require("dapui")

map("n", "<leader>du", dapui.toggle, { desc = "DAP: toggle UI" })
map({ "n", "v" }, "<leader>de", dapui.eval, { desc = "DAP: eval" })
