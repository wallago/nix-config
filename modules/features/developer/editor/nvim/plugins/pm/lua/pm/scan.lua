-- Reading the project tree: what files count, what todos they hold, which of
-- those are due today, and where a given @id lives.

local config = require("pm.config")
local fs = require("pm.fs")

local M = {}

--- Parse a todo line. Returns the disk marker char and the trailing text.
--- Two patterns per form because Lua has no alternation: bullet and ordered
--- lists.
function M.match_todo(line)
	local mark, text = line:match("^%s*[-*+]%s+%[(.)%]%s*(.*)$")
	if not mark then
		mark, text = line:match("^%s*%d+[.)]%s+%[(.)%]%s*(.*)$")
	end
	if mark then
		return mark, text
	end

	-- Unicode form. checkmate shows this in an attached buffer, and it reaches
	-- disk too when a write conversion is interrupted. The capture is a run of
	-- non-space followed by a space, then checked against the marker table, so
	-- ordinary bullets ("- some text") cannot match.
	local sym, rest = line:match("^%s*[-*+]%s+(%S+)%s+(.*)$")
	if not sym then
		sym, rest = line:match("^%s*%d+[.)]%s+(%S+)%s+(.*)$")
	end
	local md = sym and config.markers[sym]
	if md then
		return md, rest
	end
end

--- Every project file under root, gateway excluded.
function M.project_files()
	local gw = config.root .. "/" .. config.gateway
	local seen, out = {}, {}
	for _, glob in ipairs(config.globs) do
		for _, p in ipairs(vim.fn.glob(config.root .. "/" .. glob, false, true)) do
			if p ~= gw and not seen[p] then
				seen[p] = true
				table.insert(out, p)
			end
		end
	end
	table.sort(out)
	return out
end

--- Walk one file. Returns counts plus the open todo lines.
function M.scan_file(path)
	local stat = { todo = 0, running = 0, done = 0, inactive = 0, next_due = nil }
	local items = {}

	local lines = fs.read_lines(path)
	if not lines then
		return stat, items
	end

	local in_archive = false
	for lnum, line in ipairs(lines) do
		-- Any heading re-evaluates whether we're inside the archive section.
		if line:match("^#+%s+") then
			in_archive = line:lower():match("^#+%s+archive") ~= nil
		end

		if not in_archive then
			local mark, text = M.match_todo(line)
			if mark then
				local bucket = config.states[mark] or "todo"
				stat[bucket] = stat[bucket] + 1

				if bucket == "todo" or bucket == "running" then
					local due = text:match("@due%((%d%d%d%d%-%d%d%-%d%d)%)")
					if due and (not stat.next_due or due < stat.next_due) then
						stat.next_due = due
					end
					table.insert(items, {
						filename = path,
						lnum = lnum,
						line = line,
						mark = mark,
						id = text:match(config.ID_PAT),
						blocked = text:match(config.BLOCKED_PAT),
						due = due,
						state = bucket,
						text = (text:gsub("%s+$", "")),
					})
				end
			end
		end
	end

	return stat, items
end

function M.scan_all()
	local entries, all_items = {}, {}
	for _, path in ipairs(M.project_files()) do
		local stat, items = M.scan_file(path)
		local rel = path:sub(#config.root + 2)
		table.insert(entries, { path = path, rel = rel, stat = stat })
		for _, it in ipairs(items) do
			it.rel = rel
			table.insert(all_items, it)
		end
	end
	return entries, all_items
end

--- Today = anything due on or before today, plus everything in progress
--- regardless of date, so work you have started never falls off the list.
function M.today_items(items)
	local today = os.date("%Y-%m-%d")

	local out = vim.tbl_filter(function(it)
		return it.state == "running" or (it.due ~= nil and it.due <= today)
	end, items)

	table.sort(out, function(a, b)
		local ad, bd = a.due or "9999-99-99", b.due or "9999-99-99"
		if ad ~= bd then
			return ad < bd
		end
		if a.rel ~= b.rel then
			return a.rel < b.rel
		end
		return a.lnum < b.lnum
	end)
	return out
end

--- id -> { path, lnum, line } for every @id under root.
--- Built from raw lines rather than scanned items because a blocker is often an
--- already-done task, and scan_file only reports open ones. One pass, so callers
--- resolving many ids do not rescan per id.
function M.id_index()
	local index = {}
	for _, path in ipairs(M.project_files()) do
		for lnum, line in ipairs(fs.read_lines(path) or {}) do
			local id = line:match(config.ID_PAT)
			if id then
				index[id] = { path = path, lnum = lnum, line = line }
			end
		end
	end
	return index
end

--- The single source task carrying `id`. Returns nil plus a reason when there
--- is no unambiguous answer — pm never guesses which task you meant.
function M.locate(id)
	local hits = {}
	for _, path in ipairs(M.project_files()) do
		for lnum, line in ipairs(fs.read_lines(path) or {}) do
			if line:match(config.ID_PAT) == id then
				table.insert(hits, { path = path, lnum = lnum, line = line })
			end
		end
	end

	if #hits == 0 then
		return nil, ("no source task carries @id(%s) — run :PmUpdate"):format(id)
	end
	if #hits > 1 then
		return nil, ("@id(%s) appears in %d places — refusing to guess"):format(id, #hits)
	end
	return hits[1]
end

return M
