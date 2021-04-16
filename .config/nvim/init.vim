"" ----- CALL PLUGINS (VIM-PLUG) -----
call plug#begin()
Plug 'ap/vim-css-color'
Plug 'plasticboy/vim-markdown'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/fzf.vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
call plug#end()


"" ----- PLUGIN SETTINGS -----
" Automatically enable Limelight in Goyo
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!


" Trigger configuration. Do not use <tab> if you use
" https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger='<tab>'

" shortcut to go to next position
let g:UltiSnipsJumpForwardTrigger='<C-l>'

" shortcut to go to previous position
let g:UltiSnipsJumpBackwardTrigger='<C-h>'

let g:UltiSnipsSnippetDirectories=["UltiSnips", "snips"]

" Markdown file settings
set conceallevel=2
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_strikethrough = 1
let g:vim_markdown_new_list_item_indent = 0

" Limelight background settings
hi Normal ctermbg=NONE guibg=NONE
let g:limelight_conceal_ctermfg = 244


"" ----- KEYBINDS -----
" Set the leader key to ','
let mapleader =","

" Ctrl + t - new tab
map <silent> <C-t> :tabnew<CR>

" Ctrl + n - next tab
map <silent> <C-n> :tabnext<CR>

" Ctrl + w - close tab
map <silent> <C-w> :tabclose<CR>

" Ctrl + Backspace - delete last word
inoremap <C-H> <C-W>

" F2 - toggle line numbers
map <silent> <F2> :set nonumber! norelativenumber!<CR>

" F5 - clear whitespace
nnoremap <silent> <F5> :%s/\s\+$//<CR>

" F8 - enable spellchecking (use 'z=' for correction suggestions)
map <F8> :setlocal spell! spelllang=en_us<CR>

" Leader + f - fuzzy finder in the currect working directory (fzf plugin)
map <leader>f :Files %:p:h<CR>

" Leader + g - toggle Goyo
map <silent> <leader>g :Goyo \| set linebreak<CR>

" Leader + z - open the current file's pdf version using zathura
map <leader>z :w! \| !zathura %:r.pdf &<CR>

" Leader + d - convert to docx using pandoc
map <leader>d :!pandoc % -s -o %:r.docx --reference-doc=$HOME/.local/pandoc/custom-reference.docx<CR>

" Leader + c - compile to pdf using pandoc with the xelatex engine
map <leader>c :w! \| !pandoc % -s -o %:r.pdf --pdf-engine=xelatex -V 'mainfont:Times New Roman' -V 'geometry:margin=2cm'<CR>


"" ----- QUALITY OF LIFE ------
" Show tabs and whitespaces
set list listchars=nbsp:¬,tab:»·,trail:·,extends:>

" Enable undo history file
set undofile

" Recognize filetypes
filetype plugin indent on

" Enable line numbers
set relativenumber
set number

" Turn on syntax highlighting
syntax on

" Disable auto commenting on new line
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Disable case sensitivity
set ignorecase
set smartcase

" Enable autocompletion
set wildmode=longest,list,full

" Enable bottom right ruler
set ruler

" Use system clipboard (dependency: xclip)
" set clipboard+=unnamedplus

" Enable cursor line
" set cursorline
" hi cursorline cterm=none term=none
" autocmd WinEnter * setlocal cursorline
" autocmd WinLeave * setlocal nocursorline
" highlight CursorLine guibg=#303000 ctermbg=234

" Enable cursor column
" set cursorcolumn
" highlight CursorColumn guibg=#303000 ctermbg=234

" Enable the deletion of whitespace on save
" autocmd BufWritePre * %s/\s\+$//e


"" ----- AUTORUN ON FILESAVE -----
" Run xrdb whenever Xdefaults or Xresources are updated.
autocmd BufWritePost *Xresources,*Xdefaults !xrdb %

" Update binds when sxhkdrc is updated.
autocmd BufWritePost *sxhkdrc !pkill -USR1 -x sxhkd
