function SortBuffersByName()
	local buffers = {}
	for buf = 1, vim.fn.bufnr("$") do
		if vim.fn.bufexists(buf) == 1 then
			local name = vim.fn.bufname(buf)
			table.insert(buffers, { name = name, bufnr = buf })
		end
	end

	table.sort(buffers, function(a, b)
		return a.name < b.name
	end)

	for _, buf in ipairs(buffers) do
		print(vim.fn.bufname(buf.bufnr))
	end
end

-- Create a user command
vim.api.nvim_create_user_command("Ls", SortBuffersByName, {})

map("n", "<leader>bs", "<CMD>Ls<CR>", o("Sort buffers by name"))
