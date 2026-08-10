-- @id generation and stamping.
--
-- An @id is what makes a gateway line addressable: it maps a copy in the
-- generated block back to exactly one source line, so two identically worded
-- tasks can never be confused.

local config = require("pm.config")
local fs = require("pm.fs")
local scan = require("pm.scan")

local M = {}

--- Every @id currently in use anywhere under root, gateway included.
function M.taken_ids()
	local taken = {}
	local files = scan.project_files()
	table.insert(files, config.root .. "/" .. config.gateway)

	for _, path in ipairs(files) do
		for _, line in ipairs(fs.read_lines(path) or {}) do
			local id = line:match(config.ID_PAT)
			if id then
				taken[id] = true
			end
		end
	end
	return taken
end

--- A fresh id, unique against everything currently in use. Date-prefixed so ids
--- sort roughly chronologically and any clash is confined to a single day.
--- Pass `taken` when stamping in bulk to avoid rescanning per id.
function M.new_id(taken)
	taken = taken or M.taken_ids()
	local prefix = os.date("%y%m%d")

	-- hrtime, not math.random: LuaJIT's generator is unseeded at startup and
	-- would return the same first value in every session.
	for _ = 1, 1000 do
		local id = ("%s-%04x"):format(prefix, vim.loop.hrtime() % 0x10000)
		if not taken[id] then
			taken[id] = true
			return id
		end
	end
	error("pm: could not generate a unique @id")
end

--- Stamp an @id onto every Today task that lacks one. Without it there is
--- nothing to write back to. Mutates `items` in place so the caller can render
--- without rescanning.
function M.ensure_ids(items)
	local taken, edits = M.taken_ids(), {}

	for _, it in ipairs(items) do
		if not it.id then
			it.id = M.new_id(taken)
			it.text = ("%s @id(%s)"):format(it.text, it.id)
			it.line = ("%s @id(%s)"):format((it.line:gsub("%s+$", "")), it.id)
			edits[it.filename] = edits[it.filename] or {}
			edits[it.filename][it.lnum] = it.line
		end
	end

	for path, file_edits in pairs(edits) do
		if not fs.patch_lines(path, file_edits) then
			vim.notify("pm: could not stamp @id into " .. path, vim.log.levels.ERROR)
		end
	end
end

return M
