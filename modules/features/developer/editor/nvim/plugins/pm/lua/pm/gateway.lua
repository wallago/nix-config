-- Rendering and writing the generated block in gateway.md.
--
-- Everything between the markers is regenerated wholesale. Never hand-edit it.

local config = require("pm.config")
local fs = require("pm.fs")
local scan = require("pm.scan")
local ids = require("pm.ids")

local M = {}

local function render_today(items)
	local today = os.date("%Y-%m-%d")
	local out = { ("## %s · %s"):format(config.today_heading, today), "" }

	if #items == 0 then
		vim.list_extend(out, { "*nothing due — clear.*", "" })
		return out
	end

	for _, it in ipairs(items) do
		local overdue = (it.due and it.due < today) and " ⚠" or ""
		local name = it.rel:gsub("%.md$", "")
		table.insert(out, ("- [%s] %s · [%s](%s)%s"):format(it.mark, it.text, name, it.rel, overdue))
	end
	table.insert(out, "")
	return out
end

local function render_projects(entries)
	local today = os.date("%Y-%m-%d")
	local out = {
		"## Projects",
		"",
		"| project | open | doing | done | next due |",
		"| --- | ---: | ---: | ---: | --- |",
	}

	local tot = { todo = 0, running = 0, done = 0 }
	for _, e in ipairs(entries) do
		local s = e.stat
		if s.todo + s.running + s.done > 0 then
			local due = s.next_due or "—"
			if s.next_due and s.next_due < today then
				due = "**" .. due .. "** ⚠"
			end
			local name = e.rel:gsub("%.md$", "")
			table.insert(out, ("| [%s](%s) | %d | %d | %d | %s |"):format(name, e.rel, s.todo, s.running, s.done, due))
			tot.todo, tot.running, tot.done = tot.todo + s.todo, tot.running + s.running, tot.done + s.done
		end
	end

	local total = tot.todo + tot.running + tot.done
	local pct = total > 0 and math.floor(tot.done / total * 100) or 0
	table.insert(
		out,
		("| **all** | **%d** | **%d** | **%d** | %d%% done |"):format(tot.todo, tot.running, tot.done, pct)
	)
	table.insert(out, "")
	return out
end

function M.update()
	local gw = config.root .. "/" .. config.gateway
	local entries, items = scan.scan_all()
	local todays = scan.today_items(items)
	ids.ensure_ids(todays)

	local block = {
		config.BEGIN,
		("*generated %s — do not edit this block*"):format(os.date("%Y-%m-%d %H:%M")),
		"",
	}
	vim.list_extend(block, render_today(todays))
	vim.list_extend(block, render_projects(entries))
	table.insert(block, config.END)

	local lines = fs.read_lines(gw) or { "# Gateway", "", config.BEGIN, config.END, "" }

	local first, last
	for i, l in ipairs(lines) do
		if l == config.BEGIN then
			first = i
		end
		if l == config.END then
			last = i
		end
	end

	local new = {}
	if first and last and last >= first then
		vim.list_extend(new, vim.list_slice(lines, 1, first - 1))
		vim.list_extend(new, block)
		vim.list_extend(new, vim.list_slice(lines, last + 1, #lines))
	else
		-- No markers yet: append the block at the end.
		vim.list_extend(new, lines)
		table.insert(new, "")
		vim.list_extend(new, block)
	end

	-- Write the file, never the buffer: the gateway is a checkmate buffer, so
	-- setting its lines directly would put markdown markers into a buffer holding
	-- Unicode ones, and writing that back with `noautocmd` would skip checkmate's
	-- conversion and leave Unicode markers on disk.
	vim.fn.writefile(new, gw)
	fs.refresh(gw)
end

return M
