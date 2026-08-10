-- Changing a task's state from the gateway.
--
-- The gateway's Today lines are copies, so a state change here is resolved
-- through @id and written to the *source* file, then the block is regenerated.

local config = require("pm.config")
local fs = require("pm.fs")
local scan = require("pm.scan")
local gateway = require("pm.gateway")

local M = {}

--- Rewrite only the state marker, leaving indent, list style, text and metadata
--- byte-identical.
local function splice_mark(line, mark)
	local prefix = line:match("^(%s*[-*+]%s+)%[.%]") or line:match("^(%s*%d+[.)]%s+)%[.%]")
	if prefix then
		local at = #prefix + 1 -- position of '['
		return line:sub(1, at) .. mark .. line:sub(at + 2)
	end

	-- Unicode marker on disk: normalise it back to markdown, which is what
	-- checkmate writes on save anyway.
	prefix = line:match("^(%s*[-*+]%s+)%S+%s") or line:match("^(%s*%d+[.)]%s+)%S+%s")
	if not prefix then
		return nil
	end
	local rest = line:sub(#prefix + 1)
	local _, sym_len = rest:find("^%S+")
	if not sym_len or not config.markers[rest:sub(1, sym_len)] then
		return nil
	end
	return prefix .. "[" .. mark .. "]" .. rest:sub(sym_len + 1)
end

--- Put the cursor back on the task we just acted on, wherever regeneration
--- moved it to.
local function cursor_to(id)
	for lnum, line in ipairs(vim.api.nvim_buf_get_lines(0, 0, -1, false)) do
		if line:match(config.ID_PAT) == id then
			pcall(vim.api.nvim_win_set_cursor, 0, { lnum, 0 })
			return
		end
	end
end

--- Apply `fn(current_mark) -> new_mark` to the source task behind the cursor
--- line. Returns false when the line carries no @id, so the caller can fall
--- through to checkmate's own mapping.
function M.apply(fn)
	local id = vim.api.nvim_get_current_line():match(config.ID_PAT)
	if not id then
		return false
	end

	local hit, err = scan.locate(id)
	if not hit then
		vim.notify("pm: " .. err, vim.log.levels.ERROR)
		return true
	end

	local cur = scan.match_todo(hit.line)
	if not cur then
		vim.notify(("pm: source line for @id(%s) is not a todo"):format(id), vim.log.levels.ERROR)
		return true
	end

	local mark = fn(cur)
	if not mark or mark == cur then
		return true
	end

	local line = splice_mark(hit.line, mark)
	if not line or not fs.patch_lines(hit.path, { [hit.lnum] = line }) then
		vim.notify("pm: could not write " .. hit.path, vim.log.levels.ERROR)
		return true
	end

	gateway.update()
	cursor_to(id)
	return true
end

function M.toggle()
	return M.apply(function(mark)
		return config.states[mark] == "done" and " " or "x"
	end)
end

function M.check()
	return M.apply(function()
		return "x"
	end)
end

function M.uncheck()
	return M.apply(function()
		return " "
	end)
end

function M.cycle(step)
	return M.apply(function(mark)
		local order = config.cycle
		local at = 1
		for i, m in ipairs(order) do
			if m == mark then
				at = i
				break
			end
		end
		return order[(at - 1 + step) % #order + 1]
	end)
end

return M
