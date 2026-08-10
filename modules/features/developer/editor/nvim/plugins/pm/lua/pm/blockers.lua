-- @blocked(...) — what a task is waiting on.
--
-- The value is normally another task's @id, which lets pm show the blocker by
-- name and tell whether it is still open. A value that is not a known id is kept
-- verbatim: free-text blockers like @blocked(Q1) stay valid, pm just cannot tell
-- when they clear.

local config = require("pm.config")
local scan = require("pm.scan")
local ids = require("pm.ids")

local M = {}

--- Strip metadata tags, leaving the human part of a task line.
local function clean(text)
	return (text:gsub("%s*@%w+%([^)]*%)", ""):gsub("%s+$", ""))
end

--- Bare ids, for checkmate's `choices` completion. :PmBlock is the better path —
--- it shows task text and stamps an id on demand.
function M.id_choices()
	local out = {}
	for id in pairs(scan.id_index()) do
		table.insert(out, id)
	end
	table.sort(out)
	return out
end

--- Ids that a still-open task is waiting on — the tasks to do first.
--- Only open dependants count: once the task that was waiting is done, its
--- prerequisite is no longer holding anything up.
function M.required_ids()
	local required = {}
	local _, items = scan.scan_all() -- open todos only
	for _, it in ipairs(items) do
		if it.blocked then
			required[it.blocked] = true
		end
	end
	return required
end

--- Describe what `value` refers to. `index` is an optional scan.id_index() to
--- reuse across a whole render.
function M.resolve(value, index)
	if not value or value == "" then
		return nil
	end

	local hit = (index or scan.id_index())[value]
	if not hit then
		-- Free text, or an id that no longer exists.
		return { label = value, tracked = false }
	end

	local mark, text = scan.match_todo(hit.line)
	local bucket = mark and (config.states[mark] or "todo")
	return {
		label = clean(text or value),
		tracked = true,
		open = bucket == "todo" or bucket == "running",
		path = hit.path,
		lnum = hit.lnum,
	}
end

--- The annotation shown under a blocked task in the gateway, or nil.
function M.describe(value, index)
	local b = M.resolve(value, index)
	if not b then
		return nil
	end
	if b.tracked and not b.open then
		-- The blocker is finished: this task is ready to start.
		return ("✔ blocker done: %s"):format(b.label)
	end
	return ("⛔ blocked by: %s"):format(b.label)
end

--- Pick a task to be blocked by, and tag the task under the cursor with its id.
--- The chosen task is stamped with an @id if it lacks one — you can block on
--- anything, not just tasks that have already entered the Today view.
function M.pick()
	local ok, checkmate = pcall(require, "checkmate")
	if not ok then
		return vim.notify("pm: checkmate is not available", vim.log.levels.ERROR)
	end

	local _, items = scan.scan_all()
	local here = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":p")
	local row = vim.api.nvim_win_get_cursor(0)[1]

	local candidates = vim.tbl_filter(function(it)
		return not (it.filename == here and it.lnum == row)
	end, items)

	if #candidates == 0 then
		return vim.notify("pm: no other open tasks to block on", vim.log.levels.INFO)
	end

	vim.ui.select(candidates, {
		prompt = "Blocked by:",
		format_item = function(it)
			return ("%s · %s"):format((it.rel:gsub("%.md$", "")), clean(it.text))
		end,
	}, function(choice)
		if not choice then
			return
		end
		ids.ensure_ids({ choice }) -- no-op when it already has one
		checkmate.add_metadata("blocked", choice.id)
	end)
end

--- Jump to whatever is blocking the task under the cursor.
function M.goto_blocker()
	local value = vim.api.nvim_get_current_line():match(config.BLOCKED_PAT)
	if not value then
		return vim.notify("pm: no @blocked on this line", vim.log.levels.WARN)
	end

	local b = M.resolve(value)
	if not b.tracked then
		return vim.notify(("pm: @blocked(%s) is not a task id"):format(value), vim.log.levels.WARN)
	end

	vim.cmd.edit(vim.fn.fnameescape(b.path))
	pcall(vim.api.nvim_win_set_cursor, 0, { b.lnum, 0 })
end

return M
