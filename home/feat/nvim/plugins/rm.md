# Neovim/Vim Cheat Sheet

## Navigation

up = i
down = e
letf = n
right = o

| Key            | Action                         |
| -------------- | ------------------------------ |
| `s`            | Insert before cursor           |
| `S`            | Insert at beginning of line    |
| `a`            | Append after cursor            |
| `A`            | Append at end of line          |
| `r`            | Open new line below            |
| `R`            | Open new line above            |
| `ga`           | Append at end of word          |
| `gi`           | Insert at last insert position |
| `Ctrl+h`       | Delete character before cursor |
| `Ctrl+w`       | Delete word before cursor      |
| `Ctrl+u`       | Delete line before cursor      |
| `Ctrl+t`       | Indent line                    |
| `Ctrl+d`       | Un-indent line                 |
| `Ctrl+r {reg}` | Insert content from register   |
| `s`            | Insert before cursor           |
| `s`            | Insert before cursor           |
| `s`            | Insert before cursor           |
| `s`            | Insert before cursor           |
| `s`            | Insert before cursor           |
| `s`            | Insert before cursor           |
| `s`            | Insert before cursor           |
| `s`            | Insert before cursor           |
| `s`            | Insert before cursor           |

- **Motion** — moves the cursor, or defines the range for an operator
- **Command** — direct action command; if shown in white, it enters insert mode
- **Operator** — requires a motion afterwards; operates between cursor & destination
- **Extra** — special functions; requires extra input
- **q·** — commands with a dot need a char argument afterwards

---

## Number Row

| Key | Normal             | Shift               | Extra |
| --- | ------------------ | ------------------- | ----- |
| `~` | toggle case        |                     |       |
| `1` | goto mark          | `!` external filter |       |
| `2` |                    | `@·` play macro     |       |
| `3` |                    | `#` prev ident      |       |
| `4` | `$` end of line    |                     |       |
| `5` | `%` goto match     |                     |       |
| `6` | `^` soft bol       |                     |       |
| `7` | `&` repeat         |                     |       |
| `8` | `*` next ident     |                     |       |
| `9` | `(` begin sentence |                     |       |
| `0` | `)` end sentence   | `}` hard bol        |       |
| `-` | soft bol down      |                     |       |
| `+` | next line          | `=` auto format     |       |

---

## Motion — Cursor Movement

| Key | Action            |
| --- | ----------------- |
| `n` | Move cursor left  |
| `e` | Move cursor down  |
| `i` | Move cursor up    |
| `o` | Move cursor right |

### Word Movement

| Key  | Action            |
| ---- | ----------------- |
| `w`  | next word         |
| `W`  | next WORD         |
| `b`  | back word         |
| `B`  | back WORD         |
| `f·` | find char forward |
| `F·` | back find char    |
| `t·` | till char forward |
| `T·` | back till         |

### Line Movement

| Key           | Action                     |
| ------------- | -------------------------- |
| `0`           | beginning of line (bol)    |
| `^`           | first non-blank (soft bol) |
| `$`           | end of line (eol)          |
| `+` / `Enter` | first char of next line    |
| `-`           | first char of prev line    |

### Screen / Document

| Key  | Action              |
| ---- | ------------------- |
| `l`  | screen bottom       |
| `j`  | join lines          |
| `k`  | help                |
| `m·` | set mark            |
| `g`  | extra cmds (prefix) |

---

## Operators

Operators wait for a motion to define their range. Double to act on the whole line (e.g. `dd`, `yy`).

| Key | Action                   |
| --- | ------------------------ |
| `d` | delete                   |
| `c` | change (delete + insert) |
| `y` | yank (copy)              |
| `>` | indent                   |
| `<` | un-indent / reverse      |
| `=` | auto-indent              |

---

## Commands

### Entering Insert Mode

| Key  | Action             |
| ---- | ------------------ |
| `s`  | subst line         |
| `S`  | subst line (whole) |
| `a`  | append             |
| `A`  | append at eol      |
| `r·` | replace char       |
| `R`  | replace mode       |
| `o`  | open line below    |
| `O`  | open line above    |

### Actions

| Key | Action           |
| --- | ---------------- |
| `u` | undo             |
| `U` | undo line        |
| `p` | paste after      |
| `P` | paste before     |
| `x` | delete char      |
| `X` | backspace delete |
| `D` | delete to eol    |
| `J` | join lines       |
| `K` | help             |

### Visual Mode

| Key | Action       |
| --- | ------------ |
| `v` | visual lines |
| `V` | visual mode  |

### Quit / Save

| Key  | Action              |
| ---- | ------------------- |
| `Z·` | quit commands       |
| `ZZ` | save & quit         |
| `ZQ` | quit without saving |

---

## Ex Commands (Command Line)

| Command     | Action                      |
| ----------- | --------------------------- |
| `:w`        | save                        |
| `:q`        | quit                        |
| `:q!`       | quit without saving         |
| `:e f`      | open file f                 |
| `:%s/x/y/g` | replace 'x' by 'y' filewide |
| `:h`        | help                        |
| `:new`      | new file in neovim          |

---

## Other Important Commands

| Key                 | Action                |
| ------------------- | --------------------- |
| `Ctrl-R`            | redo                  |
| `Ctrl-F` / `Ctrl-B` | page up / down        |
| `Ctrl-E` / `Ctrl-Y` | scroll line up / down |
| `Ctrl-V`            | block visual mode     |

---

## Registers & Repeat

| Concept                      | Usage                                                      |
| ---------------------------- | ---------------------------------------------------------- |
| `"x` before yank/paste/del   | use register 'x' (`"a-z`, `"+`)                            |
| `"ay$`                       | yank to end of line into register 'a'                      |
| `(number)` before any action | repeat that action N times (e.g. `2p`, `d2w`, `5l`, `d6j`) |
| `.`                          | repeat last change                                         |
| `dd`                         | delete line                                                |
| `yy`                         | yank line                                                  |
| `>>`                         | indent line                                                |

---

## Scroll & Navigation

| Key  | Action                  |
| ---- | ----------------------- |
| `zt` | scroll cursor to top    |
| `zb` | scroll cursor to bottom |
| `zz` | scroll cursor to center |
| `gg` | top of file             |
| `G`  | bottom of file          |
| `gf` | open file under cursor  |

---

## Words vs WORDs

- **word**: sequence of letters/digits/underscores, separated by other chars
  - `q u x ( f o o , b a r , b a z ) ;` → each punctuation/space is a boundary
- **WORD**: sequence of non-blank chars, separated by whitespace only
  - `qux(foo,` `bar,` `baz);` → only spaces break WORDs

---

## Abbreviations

| Abbr  | Meaning           |
| ----- | ----------------- |
| bol   | beginning of line |
| eol   | end of line       |
| mk    | mark              |
| yank  | copy              |
| char  | character         |
| parag | paragraph         |
| cmd   | command           |
