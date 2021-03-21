" Recognize filetypes
filetype plugin indent on

" Enable line numbers
:set relativenumber
:set number

" Turn on syntax highlighting
:syntax on

" Use system clipboard (dependency: xclip)
" set clipboard+=unnamedplus

" Enable cursor line
set cursorline
hi cursorline cterm=none term=none
autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline
highlight CursorLine guibg=#303000 ctermbg=234

" Enable cursor column
set cursorcolumn
highlight CursorColumn guibg=#303000 ctermbg=234

" Enable the deletion of trailing whitespace on save
" autocmd BufWritePre * %s/\s\+$//e

" Disable auto commenting
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Disable case sensitivity
set ignorecase
set smartcase

" Enable autocompletion
set wildmode=longest,list,full

" Run xrdb whenever Xdefaults or Xresources are updated.
autocmd BufWritePost *Xresources,*Xdefaults !xrdb %
" Update binds when sxhkdrc is updated.
autocmd BufWritePost *sxhkdrc !pkill -USR1 -x sxhkd
