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
Exemple: `"a` + `yy`

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
Exemple: `ma` + `'a` / `` `a` `

- `'`: Takes you to the line (start of line),
- `` ` ``: Takes you to the exact position.
- `a–z`: Your own bookmarks, per file. Drop them, jump back.
- `A–Z`: Global marks — survive across files.

| Action                             | Key             |
| ---------------------------------- | --------------- |
| Mark                               | `'` / `` ` ``   |
| Last position before the last jump | `''` / `` `' `` |
| Last position before exited buffer | `'"` / `` `" `` |
| End of last yank                   | `']` / `` `] `` |
| Start of last yank                 | `'[` / `` `[ `` |
| Last position in insert mode       | `'^` / `` `^ `` |
| Last change in buffer              | `'.` / `` `. `` |
| End of last visual selection       | `'>` / `` `> `` |
| Start of last visual selection     | `'<` / `` `< `` |

## Run Program

| Action      | Key |
| ----------- | --- |
| Run Program | `!` |

## File Explorer (Oil)

| Action          | Key          |
| --------------- | ------------ |
| Parent dir      | `-`          |
| Floating window | `<leader>-`  |
| File explorer   | `<leader>fe` |

## LSP

| Action            | Key          |
| ----------------- | ------------ |
| Go to definition  | `gd`         |
| Go to declaration | `gD`         |
| References        | `gr`         |
| Implementation    | `gI`         |
| Hover             | `gh`         |
| Rename            | `<leader>rn` |
| Code action       | `<leader>ca` |
| Prev diagnostic   | `[d`         |
| Next diagnostic   | `]d`         |

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
