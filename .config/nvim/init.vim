"" ----- CALL PLUGINS -----
call plug#begin()
Plug 'ap/vim-css-color'
Plug 'plasticboy/vim-markdown'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
call plug#end()


"" ----- PLUGIN SETTINGS -----
" Automatically enable Limelight in Goyo
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" Disable folding in markdown files
let g:vim_markdown_folding_disabled = 1

" Limelight bg settings
hi Normal ctermbg=NONE guibg=NONE
let g:limelight_conceal_ctermfg = 244


"" ----- KEYBINDS -----
" Set leader key to ','
let mapleader =","

" leader + F toggles Goyo
map <leader>f :Goyo \| set linebreak<CR>

" Ctrl+Backspace deletes last word
inoremap <C-H> <C-W>

" F8 enables spellchecking (use 'z=' for correction suggestions)
map <F8> :setlocal spell! spelllang=en_us<CR>

" F5 clears whitespace
nnoremap <silent> <F5> :%s/\s\+$//<cr>


"" ----- QUALITY OF LIFE ------
" Show if there is a tab or not
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

" Disable auto commenting
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Disable case sensitivity
set ignorecase
set smartcase

" Enable autocompletion
set wildmode=longest,list,full


" Use system clipboard (dependency: xclip)
" set clipboard+=unnamedplus

" Enable cursor line
" set cursorline
" hi cursorline cterm=none term=none
" autocmd WinEnter * setlocal cursorline
" autocmd WinLeave * setlocal nocursorline
" highlight CursorLine guibg=#303000 ctermbg=234
"
" " Enable cursor column
" set cursorcolumn
" highlight CursorColumn guibg=#303000 ctermbg=234

" Enable the deletion of whitespace on save
" autocmd BufWritePre * %s/\s\+$//e


"" ----- AUTORUN ON FILESAVE -----
" Run xrdb whenever Xdefaults or Xresources are updated.
autocmd BufWritePost *Xresources,*Xdefaults !xrdb %

" Update binds when sxhkdrc is updated.
autocmd BufWritePost *sxhkdrc !pkill -USR1 -x sxhkd
