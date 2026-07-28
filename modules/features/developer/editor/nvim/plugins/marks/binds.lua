local m = require("marks")
local map = vim.keymap.set

-- mark navigation (mirrors vim's native ['  ]' for marks)
map("n", "['", m.prev, { desc = "marks: prev" })
map("n", "]'", m.next, { desc = "marks: next" })
-- bookmark navigation (same type under cursor)
map("n", "[b", m.prev_bookmark, { desc = "marks: prev bookmark" })
map("n", "]b", m.next_bookmark, { desc = "marks: next bookmark" })

map("n", "<leader>md", m.delete, { desc = "marks: delete mark…" })
map("n", "<leader>mm", m.set_next, { desc = "marks: set next available" })
map("n", "<leader>mt", m.toggle, { desc = "marks: toggle at line" })
map("n", "<leader>mp", m.preview, { desc = "marks: preview" })
map("n", "<leader>ml", m.delete_line, { desc = "marks: delete all on line" })
map("n", "<leader>mD", m.delete_buf, { desc = "marks: delete all in buffer" })
map("n", "<leader>mx", m.delete_bookmark, { desc = "marks: delete under cursor" })
