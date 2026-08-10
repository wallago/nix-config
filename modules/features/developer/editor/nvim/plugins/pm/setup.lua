-- ~/.config/nvim/lua/pm/init.lua
--
-- Cross-project dashboard for a directory of checkmate.nvim markdown files.
--
--   :PmUpdate   regenerate the gateway block in <root>/gateway.md
--   :PmTasks    quickfix list of every open todo across all projects
--   :PmDue      quickfix list of open todos with a @due(...) tag, soonest first
--
-- The gateway is GENERATED. Never hand-edit between the markers.

local M = {}

M.config = {
	root = vim.fn.expand("~/sync-pm"),
	gateway = "gateway.md",
	auto_update = true, -- regenerate on write of any file under root

	-- Disk markers -> bucket. These are the raw markdown chars, not the
	-- Unicode markers checkmate shows in the buffer.
	states = {
		[" "] = "todo",
		["x"] = "done",
		["X"] = "done",
		["."] = "running", -- in_progress
		["c"] = "done", -- cancelled: complete for counting purposes
		["/"] = "inactive", -- on_hold: excluded from totals
	},
}

local BEGIN, END = "<!-- pm:begin -->", "<!-- pm:end -->"

--------------------------------------------------------------------- scanning

-- Two patterns because Lua has no alternation: bullet lists and ordered lists.
local function match_todo(line)
	local mark, text = line:match("^%s*[-*+]%s+%[(.)%]%s*(.*)$")
	if mark then
		return mark, text
	end
	return line:match("^%s*%d+[.)]%s+%[(.)%]%s*(.*)$")
end

--- Walk one file. Returns counts plus the raw todo lines (for quickfix).
function M.scan_file(path)
	local stat = { todo = 0, running = 0, done = 0, inactive = 0, next_due = nil }
	local items = {}

	local ok, lines = pcall(vim.fn.readfile, path)
	if not ok then
		return stat, items
	end

	local in_archive = false
	for lnum, line in ipairs(lines) do
		-- Any heading re-evaluates whether we're inside the archive section.
		if line:match("^#+%s+") then
			in_archive = line:lower():match("^#+%s+archive") ~= nil
		end

		if not in_archive then
			local mark, text = match_todo(line)
			if mark then
				local bucket = M.config.states[mark] or "todo"
				stat[bucket] = stat[bucket] + 1

				if bucket == "todo" or bucket == "running" then
					local due = text:match("@due%((%d%d%d%d%-%d%d%-%d%d)%)")
					if due and (not stat.next_due or due < stat.next_due) then
						stat.next_due = due
					end
					table.insert(items, {
						filename = path,
						lnum = lnum,
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

--- Every project file under root, gateway excluded.
function M.project_files()
	local gw = M.config.root .. "/" .. M.config.gateway
	local out = {}
	for _, p in ipairs(vim.fn.globpath(M.config.root, "**/*.md", false, true)) do
		if p ~= gw then
			table.insert(out, p)
		end
	end
	table.sort(out)
	return out
end

function M.scan_all()
	local entries, all_items = {}, {}
	for _, path in ipairs(M.project_files()) do
		local stat, items = M.scan_file(path)
		local rel = path:sub(#M.config.root + 2)
		table.insert(entries, { path = path, rel = rel, stat = stat })
		vim.list_extend(all_items, items)
	end
	return entries, all_items
end

------------------------------------------------------------------- rendering

local function render(entries)
	local today = os.date("%Y-%m-%d")
	local out = {
		BEGIN,
		("*generated %s — do not edit this block*"):format(os.date("%Y-%m-%d %H:%M")),
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
	table.insert(out, END)
	return out
end

--------------------------------------------------------------------- writing

function M.update()
	local gw = M.config.root .. "/" .. M.config.gateway
	local entries = M.scan_all()
	local block = render(entries)

	local lines = vim.fn.filereadable(gw) == 1 and vim.fn.readfile(gw)
		or {
			"# Gateway",
			"",
			BEGIN,
			END,
			"",
		}

	local first, last
	for i, l in ipairs(lines) do
		if l == BEGIN then
			first = i
		end
		if l == END then
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

	vim.fn.writefile(new, gw)
	vim.cmd("silent! checktime") -- refresh the gateway buffer if it's open
end

------------------------------------------------------------------- quickfix

local function to_qf(items, title)
	if #items == 0 then
		return vim.notify("pm: nothing to show", vim.log.levels.INFO)
	end
	local qf = {}
	for _, it in ipairs(items) do
		local prefix = it.state == "running" and "[doing] " or ""
		table.insert(qf, {
			filename = it.filename,
			lnum = it.lnum,
			text = prefix .. it.text,
		})
	end
	vim.fn.setqflist({}, " ", { title = title, items = qf })
	vim.cmd("copen")
end

function M.tasks()
	local _, items = M.scan_all()
	to_qf(items, "pm: open tasks")
end

function M.due()
	local _, items = M.scan_all()
	local dated = vim.tbl_filter(function(i)
		return i.due
	end, items)
	table.sort(dated, function(a, b)
		return a.due < b.due
	end)
	for _, i in ipairs(dated) do
		i.text = i.due .. "  " .. i.text
	end
	to_qf(dated, "pm: by due date")
end

----------------------------------------------------------------------- nav

function M.open()
	local line = vim.api.nvim_get_current_line()
	local col = vim.api.nvim_win_get_cursor(0)[2] + 1

	local target, init = nil, 1
	while true do
		local s, e, t = line:find("%[[^%]]*%]%(([^)]+)%)", init)
		if not s then
			break
		end
		if not target then
			target = t
		end
		if col >= s and col <= e then
			target = t
			break
		end
		init = e + 1
	end

	if not target then
		return vim.notify("pm: no link on this line", vim.log.levels.WARN)
	end
	if target:match("^%a[%w+.-]*://") then
		return vim.ui.open(target)
	end

	local dir = vim.fn.expand("%:p:h")
	vim.cmd.edit(vim.fn.fnameescape(vim.fs.normalize(dir .. "/" .. target)))
end

----------------------------------------------------------------------- setup

function M.setup(opts)
	M.config = vim.tbl_deep_extend("force", M.config, opts or {})

	vim.api.nvim_create_user_command("PmUpdate", M.update, {})
	vim.api.nvim_create_user_command("PmTasks", M.tasks, {})
	vim.api.nvim_create_user_command("PmDue", M.due, {})

	if M.config.auto_update then
		vim.api.nvim_create_autocmd("BufWritePost", {
			pattern = "*.md",
			callback = function(ev)
				local path = vim.fn.fnamemodify(ev.file, ":p")
				local gw = M.config.root .. "/" .. M.config.gateway
				if path:find(M.config.root, 1, true) == 1 and path ~= gw then
					M.update()
				end
			end,
		})
	end
	vim.api.nvim_create_autocmd("FileType", {
		pattern = "markdown",
		callback = function(ev)
			local path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(ev.buf), ":p")
			if path:find(M.config.root, 1, true) ~= 1 then
				return
			end
			vim.bo[ev.buf].suffixesadd = ".md" -- makes plain gf work on bare names too
			vim.keymap.set("n", "<CR>", M.open, {
				buffer = ev.buf,
				desc = "pm: follow link",
			})
		end,
	})
end

return M
