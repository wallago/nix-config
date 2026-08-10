-- In-buffer marker for tasks that something else is waiting on.
--
-- The marker goes on the *prerequisite* — the task carrying the @id that some
-- still-open task references with @blocked. It means "do this one first".
-- Icon only, no text.
--
-- Display only: everything here is extmarks, so no bytes ever change on disk.

local config = require("pm.config")
local blockers = require("pm.blockers")

local M = {}

local NS = vim.api.nvim_create_namespace("pm.required")

-- Finding dependants means a pass over every project file. Renders fire on each
-- change, so hold the result briefly rather than rebuilding it per keystroke.
local cache = { at = 0, ids = nil }

local function required_ids()
	local now = vim.uv.now()
	if cache.ids and (now - cache.at) < 1000 then
		return cache.ids
	end
	cache.ids, cache.at = blockers.required_ids(), now
	return cache.ids
end

--- Mark every task in `bufnr` that another open task depends on.
function M.render(bufnr)
	bufnr = bufnr or vim.api.nvim_get_current_buf()
	if not vim.api.nvim_buf_is_loaded(bufnr) then
		return
	end
	vim.api.nvim_buf_clear_namespace(bufnr, NS, 0, -1)

	-- Resolved lazily: a file whose tasks nothing depends on should cost nothing
	-- beyond one pass over its lines.
	local required
	for lnum, line in ipairs(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)) do
		local id = line:match(config.ID_PAT)
		if id then
			required = required or required_ids()
			if required[id] then
				pcall(vim.api.nvim_buf_set_extmark, bufnr, NS, lnum - 1, 0, {
					virt_text = { { "  " .. config.required_marker, "PmRequired" } },
					virt_text_pos = "eol",
					hl_mode = "combine",
				})
			end
		end
	end
end

--- Render now, and again whenever the buffer changes.
function M.attach(bufnr)
	M.render(bufnr)
	vim.api.nvim_create_autocmd({ "BufWritePost", "TextChanged", "InsertLeave", "BufWinEnter" }, {
		buffer = bufnr,
		callback = function()
			M.render(bufnr)
		end,
	})
end

--- `default = true` so a colourscheme can override this.
function M.setup_highlights()
	vim.api.nvim_set_hl(0, "PmRequired", { link = "DiagnosticVirtualTextWarn", default = true })
end

return M
