-- Defaults for pm.
--
-- `require("pm").setup(opts)` merges into this table *in place*, because every
-- other module holds a reference to it.

return {
	root = vim.fn.expand("~/sync-pm"),
	gateway = "gateway.md",
	auto_update = true, -- regenerate on write of any file under root
	today_heading = "Today",

	-- Shown at the end of a task that another open task is waiting on: "do this
	-- one first". Marker only, deliberately without text.
	required_marker = "⚑  ",

	-- Which files under root count as projects. Keep in step with checkmate's
	-- `files` globs: pm must not claim notes checkmate does not manage.
	globs = { "projects/*.md", "work/*.md", "perso/*.md" },

	-- Unicode marker -> disk marker. checkmate shows these in an attached
	-- buffer; they also turn up on disk when a write conversion is interrupted.
	-- Mirrors `todo_states` in the checkmate config.
	markers = {
		["□"] = " ",
		["✔"] = "x",
		["▶"] = ".",
		["✗"] = "c",
		["⊘"] = "/",
	},

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

	-- Structural constants. Not meant to be overridden.
	BEGIN = "<!-- pm:begin -->",
	END = "<!-- pm:end -->",
	ID_PAT = "@id%(([%w%-]+)%)",
	BLOCKED_PAT = "@blocked%(([^)]*)%)",
}
