-- Movement: NEIO replaces HJKL (n=← e=↓ i=↑ o=→), I/E take H/L
-- (top/bottom of screen) and T takes K (keyword lookup)  ─────────────
for _, mode in ipairs({ "n", "v", "x", "o" }) do
	map(mode, "n", "h", o("← left"))
	map(mode, "e", "j", o("↓ down"))
	map(mode, "i", "k", o("↑ up"))
	map(mode, "o", "l", o("→ right"))

	map(mode, "I", "H", o("Top of screen"))
	map(mode, "E", "L", o("Bottom of screen"))
	map(mode, "T", "K", o("Look up keyword"))
end

-- Re-home the commands NEIO displaced:
-- search n/N → h/H, word-end e/E → k/K, insert i/I → l/L,
-- open-line o/O → j/J, prev-word-end ge → gk  ────────────────────────
map({ "n", "v" }, "h", "n", o("Next search"))
map({ "n", "v" }, "H", "N", o("Prev search"))
map({ "n", "x", "o" }, "k", "e", o("End of word"))
map({ "n", "x", "o" }, "K", "E", o("End of WORD"))
map("n", "l", "i", o("Insert"))
map("n", "L", "I", o("Insert at line start"))
map("n", "j", "o", o("Open line below"))
map("n", "J", "O", o("Open line above"))
map({ "n", "x", "o" }, "gk", "ge", o("Prev end of word"))

-- Display-line variants: in n/v mode e/i use gj/gk (overriding the
-- plain j/k from the loop above) so wrapped lines aren't skipped  ────
map("n", "e", "gj", o("↓ down (visual line)"))
map("n", "i", "gk", o("↑ up (visual line)"))
map("v", "e", "gj", o("↓ down (visual line)"))
map("v", "i", "gk", o("↑ up (visual line)"))
map("o", "e", "gj", o("↓ down (charwise)"))
map("o", "i", "gk", o("↑ up (charwise)"))

-- Textobjects: i/o are movement now, so in visual/operator mode
-- l = inner textobject (was i), O = swap selection ends (was o)  ─────
map({ "x", "o" }, "l", "i", o("Inner textobject"))
map("x", "O", "o", o("Swap selection ends"))
