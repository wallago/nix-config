-- Ways of getting to a task: quickfix lists, link following, and jumping from a
-- gateway line to the exact source line behind it.

local config = require("pm.config")
local scan = require("pm.scan")

local M = {}

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
	local _, items = scan.scan_all()
	to_qf(items, "pm: open tasks")
end

function M.today()
	local _, items = scan.scan_all()
	to_qf(scan.today_items(items), "pm: today")
end

function M.due()
	local _, items = scan.scan_all()
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

--- Follow the markdown link under the cursor, or the first one on the line.
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

--- On a Today line, jump to the exact source task; otherwise follow the link.
function M.goto_source()
	local id = vim.api.nvim_get_current_line():match(config.ID_PAT)
	if not id then
		return M.open()
	end

	local hit, err = scan.locate(id)
	if not hit then
		return vim.notify("pm: " .. err, vim.log.levels.ERROR)
	end
	vim.cmd.edit(vim.fn.fnameescape(hit.path))
	pcall(vim.api.nvim_win_set_cursor, 0, { hit.lnum, 0 })
end

return M
