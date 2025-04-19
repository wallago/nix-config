" Basic settings
set number
"set relativenumber
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smartindent
set termguicolors
set cursorline
set cursorlineopt=number
"set signcolumn=yes

" Rust-specific settings
let g:rustfmt_autosave = 1
let g:rust_clip_command = 'xclip -selection clipboard'

" CoC settings
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                            \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Function needed for CoC tab completion
function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

