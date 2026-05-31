# Neovim - Editor

## Movement

### Windows

| Action      | Key      |
| ----------- | -------- |
| Focus Left  | `<C-w>n` |
| Focus Down  | `<C-w>e` |
| Focus Up    | `<C-w>i` |
| Focus Right | `<C-w>o` |

### Screen

| Action           | Key |
| ---------------- | --- |
| Top of screen    | `I` |
| Bottom of screen | `E` |
| Middle of screen | `M` |

### Line

| Action                   | Key  |
| ------------------------ | ---- |
| Start of line            | `0`  |
| Start of line (no space) | `^`  |
| End of line              | `$`  |
| Down line                | `e`  |
| Up line                  | `i`  |
| First line               | `gg` |
| Last line                | `G`  |
| Previous empty line      | `{`  |
| Next empty line          | `}`  |

### Word

| Action               | Key  |
| -------------------- | ---- |
| Previous word        | `b`  |
| Previous WORD        | `B`  |
| End of word          | `k`  |
| End of WORD          | `K`  |
| Previous end of WORD | `gk` |
| Next word            | `k`  |
| Next Word            | `k`  |

### Char

| Action     | Key |
| ---------- | --- |
| Left char  | `n` |
| Right char | `o` |

### Tab

| Action | Key       |
| ------ | --------- |
| Indent | `>` / `<` |

## Insert

| Action                | Key |
| --------------------- | --- |
| Insert                | `l` |
| Insert at line start  | `L` |
| Insert on line bellow | `j` |
| Insert on line above  | `J` |

## Insert

| Action | Key |
| ------ | --- |
| Delete | `d` |

## Change

| Action | Key |
| ------ | --- |
| Change | `c` |

## Rebase

| Action | Key |
| ------ | --- |
| Rebase | `r` |

## Visual

| Action                     | Key  |
| -------------------------- | ---- |
| Visual                     | `v`  |
| Visual Line                | `V`  |
| Last visual Selection      | `gv` |
| Comment selection (v mode) | `gc` |

## Yank

| Action | Key |
| ------ | --- |
| Yank   | `y` |

## Register (clipboard slot)

Press `"` and on whatever key (almost) to select a slot.
After yank it will put in this slot.
Example: `"a` + `yy`

| Action                                              | Key  |
| --------------------------------------------------- | ---- |
| Register                                            | `"`  |
| Sync with system clipboard                          | `"+` |
| Last deleted, yank, changed content                 | `""` |
| Last deleted, changed content smaller than one line | `"-` |
| Most execute command                                | `":` |
| Last inserted text                                  | `".` |
| Nave of the current file                            | `"%` |
| Last search pattern                                 | `"/` |
| Last yank                                           | `"0` |
| Black hole                                          | `"_` |

## Mark (bookmark)

Press `m` and on whatever key (almost) to place a mark.
After you can go back there.
Example: `ma` + `'a` / `` `a ``

- `'`: Takes you to the line (start of line),
- `` ` ``: Takes you to the exact position.
- `a–z`: Your own bookmarks, per file. Drop them, jump back.
- `A–Z`: Global marks — survive across files.

| Action                             | Key             |
| ---------------------------------- | --------------- |
| Last position before the last jump | `''` / `` `' `` |
| Last position before exited buffer | `'"` / `` `" `` |
| End of last yank                   | `']` / `` `] `` |
| Start of last yank                 | `'[` / `` `[ `` |
| Last position in insert mode       | `'^` / `` `^ `` |
| Last change in buffer              | `'.` / `` `. `` |
| End of last visual selection       | `'>` / `` `> `` |
| Start of last visual selection     | `'<` / `` `< `` |

| Action                                                          | Key          |
| --------------------------------------------------------------- | ------------ |
| Set Mark `x`                                                    | `mx`         |
| Set the next available alphabetical (lowercase)                 | `<space>mm`  |
| Toggle the next available mark at the current line              | `<space>mt`  |
| Delete mark `x`                                                 | `<space>mdx` |
| Delete all marks on the current line                            | `<space>ml`  |
| Delete all marks in the current buffer                          | `<space>mD`  |
| Move to next mark                                               | `]'`         |
| Move to previous mark                                           | `['`         |
| Preview mark                                                    | `<space>mp`  |
| Move to the next bookmark having the same type under cursor     | `]b`         |
| Move to the previous bookmark having the same type under cursor | `[b`         |
| Delete the bookmark under the cursor                            | `<space>mx`  |

## Tabs

A `tab` is a layout of `buffer`.

| Action             | Key           |
| ------------------ | ------------- |
| Open a new tab     | `<space>tn`   |
| Close a tab        | `<space>tc`   |
| Close others tabs  | `<space>to`   |
| Move tab forward   | `<space>tf`   |
| Move tab backward  | `<space>tb`   |
| Go to next tab     | `<tab>`       |
| Go to previous tab | `<shift-tab>` |

## Buffers

| Action          | Key     |
| --------------- | ------- |
| Quit buf        | `<C-q>` |
| Save & Quit buf | `<C-x>` |
| Quit all bufs   | `<C-o>` |
| Save buf        | `<C-s>` |

## Run Program

| Action      | Key |
| ----------- | --- |
| Run Program | `!` |

## File Explorer (Oil)

| Action          | Key         |
| --------------- | ----------- |
| Parent dir      | `-`         |
| Floating window | `<space>-`  |
| File explorer   | `<space>fe` |

## LSP

| Action            | Key         |
| ----------------- | ----------- |
| Go to definition  | `gd`        |
| Go to declaration | `gD`        |
| References        | `gr`        |
| Implementation    | `gI`        |
| Hover             | `gh`        |
| Rename            | `<space>rn` |
| Code action       | `<space>ca` |
| Prev diagnostic   | `[d`        |
| Next diagnostic   | `]d`        |

## Search

| Action          | Key |
| --------------- | --- |
| Next search     | `h` |
| Previous search | `H` |
| Search forward  | `/` |
| Search backward | `?` |

## Indent

| Action | Key       |
| ------ | --------- |
| Indent | `>` / `<` |

## Telescope (Find)

| Action           | Key          |
| ---------------- | ------------ |
| Find files       | `<leader>ff` |
| Grep project     | `<leader>fg` |
| Buffers          | `<leader>fb` |
| Help             | `<leader>fh` |
| Resume picker    | `<leader>fr` |
| Keymaps          | `<leader>fk` |
| Search in buffer | `<leader>/`  |
| Paste history    | `<leader>p`  |
| Registers        | `<leader>"`  |
| Marks            | `<leader>'`  |

### In Telescope Prompt

| Action    | Key     |
| --------- | ------- |
| Next item | `<C-e>` |
| Prev item | `<C-i>` |

## Rustacean

| Action                                | Key         |
| ------------------------------------- | ----------- |
| Run test under cursor / in file       | `<space>rt` |
| Pick a main/example/bin to run        | `<space>rr` |
| Run debugger                          | `<space>rd` |
| recursively expand macro under cursor | `<space>rm` |
| `rustc --explain` for the error       | `<space>re` |
| Jump to the crate's manifest          | `<space>rc` |
| Jump to parent mod                    | `<space>rp` |
| Docs for symbol under cursor          | `<space>rD` |

## Debugger

| Action                 | Key         |
| ---------------------- | ----------- |
| Toggle                 | `<space>db` |
| Conditional breakpoint | `<space>dB` |
| Continue / Start       | `<space>dc` |
| Step into              | `<space>di` |
| Step over              | `<space>do` |
| Step out               | `<space>dO` |
| Eval expression        | `<space>de` |
| Toggle UI              | `<space>du` |
| Toggle REPL            | `<space>dr` |
| Run last               | `<space>dl` |
| Terminate              | `<space>dt` |

## Diagnostic

| Action                                        | Key         |
| --------------------------------------------- | ----------- |
| All diagnostics in the workspace (every file) | `<space>xx` |
| Diagnostics in the current buffer only        | `<space>xX` |
| Symbol outline of the current file            | `<space>xs` |
| lSP references/definitions (right sidebar)    | `<space>xl` |
| Location list                                 | `<space>xL` |
| Quickfix list                                 | `<space>xQ` |

## Misc

| Action                             | Key  |
| ---------------------------------- | ---- |
| Look up keyword                    | `T`  |
| Matching                           | `%`  |
| Toggle case                        | `~`  |
| Repeat last command                | `.`  |
| Change sort                        | `gs` |
| Go to file under cursor            | `gf` |
| Opens filepath or URI under cursor | `gx` |
| Uppercase                          | `gU` |
| Lowercase                          | `gu` |
| Moving to older edit position      | `g;` |
| Moving to newer edit position      | `g,` |

## Questions

- What is format at `gw`
- What is toggle case at `g~`
- Search more about `v-block`
