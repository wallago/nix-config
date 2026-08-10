-- File access for pm.
--
-- Disk is canonical, always. checkmate rewrites an attached buffer's markers to
-- Unicode on attach and only converts back at write time, so buffer text is a
-- *rendering* rather than the source of truth — reading it makes every open file
-- scan as empty.

local M = {}

--- Loaded buffer holding `path`, if any.
function M.buf_for(path)
	for _, b in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_loaded(b) and vim.api.nvim_buf_get_name(b) == path then
			return b
		end
	end
end

function M.read_lines(path)
	local ok, lines = pcall(vim.fn.readfile, path)
	return ok and lines or nil
end

--- Reload `path`'s buffer so it picks up a change written underneath it.
--- A buffer with unsaved changes is left alone and reported: reloading would
--- throw those edits away, and saving would put stale content back over ours.
function M.refresh(path)
	local bufnr = M.buf_for(path)
	if not bufnr then
		return
	end
	if vim.bo[bufnr].modified then
		vim.notify(
			("pm: %s has unsaved changes — reload it to see pm's edit"):format(vim.fn.fnamemodify(path, ":t")),
			vim.log.levels.WARN
		)
		return
	end
	-- :edit rather than checktime so checkmate reattaches and re-renders.
	vim.api.nvim_buf_call(bufnr, function()
		vim.cmd("silent! edit")
	end)
end

--- Replace individual lines in `path`. `edits` maps 1-based lnum -> new text.
function M.patch_lines(path, edits)
	if vim.tbl_isempty(edits) then
		return true
	end

	local lines = M.read_lines(path)
	if not lines then
		return false
	end
	for lnum, text in pairs(edits) do
		if lines[lnum] then
			lines[lnum] = text
		end
	end
	if not pcall(vim.fn.writefile, lines, path) then
		return false
	end

	M.refresh(path)
	return true
end

return M
