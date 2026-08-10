-- pm — cross-project dashboard for a directory of checkmate.nvim markdown files.
--
--   :PmUpdate   regenerate the gateway block in <root>/gateway.md
--   :PmToday    quickfix list of today's tasks
--   :PmTasks    quickfix list of every open todo across all projects
--   :PmDue      quickfix list of open todos with a @due(...) tag, soonest first
--   :PmBlock    pick a task for @blocked(...) on the task under the cursor
--   :PmBlocker  jump to whatever is blocking the task under the cursor
--
-- The gateway is GENERATED. Never hand-edit between the markers.
--
-- The "Today" section is a read-only view. <CR> on a task takes you to it in its
-- own file, where you edit it with checkmate as normal. Gateway lines resolve to
-- their origin by @id(...), never by text or line number, so two identically
-- worded tasks can never be confused. pm stamps an @id onto any task that enters
-- the Today view.
--
--   config.lua   defaults
--   fs.lua       disk access (disk is canonical, buffers are a rendering)
--   scan.lua     which files count, what todos they hold, @id lookup
--   ids.lua      @id generation and stamping
--   gateway.lua  rendering and writing the generated block
--   blockers.lua @blocked(...) resolution and picking
--   hints.lua    in-buffer virtual text for blocked tasks
--   nav.lua      quickfix lists and jumping to source

local config = require("pm.config")
local scan = require("pm.scan")
local ids = require("pm.ids")
local gateway = require("pm.gateway")
local blockers = require("pm.blockers")
local hints = require("pm.hints")
local nav = require("pm.nav")

local M = {}

M.config = config

-- Flat public surface. checkmate's @id metadata calls require("pm").new_id().
M.taken_ids = ids.taken_ids
M.new_id = ids.new_id
M.ensure_ids = ids.ensure_ids
M.match_todo = scan.match_todo
M.project_files = scan.project_files
M.scan_file = scan.scan_file
M.scan_all = scan.scan_all
M.today_items = scan.today_items
M.locate = scan.locate
M.id_index = scan.id_index
M.update = gateway.update
M.id_choices = blockers.id_choices
M.block = blockers.pick
M.goto_blocker = blockers.goto_blocker
M.tasks = nav.tasks
M.today = nav.today
M.due = nav.due
M.open = nav.open
M.goto_source = nav.goto_source

function M.setup(opts)
	-- Merge in place: every module holds a reference to this table, so replacing
	-- it would leave them all reading the defaults.
	for k, v in pairs(vim.tbl_deep_extend("force", config, opts or {})) do
		config[k] = v
	end
	local gw = config.root .. "/" .. config.gateway
	hints.setup_highlights()

	vim.api.nvim_create_user_command("PmUpdate", function()
		gateway.update()
	end, {})
	vim.api.nvim_create_user_command("PmToday", nav.today, {})
	vim.api.nvim_create_user_command("PmTasks", nav.tasks, {})
	vim.api.nvim_create_user_command("PmDue", nav.due, {})
	vim.api.nvim_create_user_command("PmBlock", blockers.pick, {})
	vim.api.nvim_create_user_command("PmBlocker", blockers.goto_blocker, {})

	if config.auto_update then
		vim.api.nvim_create_autocmd("BufWritePost", {
			pattern = "*.md",
			callback = function(ev)
				local path = vim.fn.fnamemodify(ev.file, ":p")
				if path:find(config.root, 1, true) == 1 and path ~= gw then
					gateway.update()
				end
			end,
		})
	end

	vim.api.nvim_create_autocmd("FileType", {
		pattern = "markdown",
		callback = function(ev)
			local path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(ev.buf), ":p")
			if path:find(config.root, 1, true) ~= 1 then
				return
			end
			vim.bo[ev.buf].suffixesadd = ".md" -- makes plain gf work on bare names too
			hints.attach(ev.buf) -- show what each @blocked task is waiting on
			-- One mapping covers both cases: goto_source jumps to the task behind
			-- an @id and falls back to following the link when there isn't one.
			vim.keymap.set("n", "<CR>", nav.goto_source, {
				buffer = ev.buf,
				desc = "pm: go to task / follow link",
			})
		end,
	})
end

return M
