"" ----- CALL PLUGINS (VIM-PLUG) -----
call plug#begin()
Plug 'ap/vim-css-color'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/fzf.vim'
Plug 'plasticboy/vim-markdown'
Plug 'dkarter/bullets.vim'
Plug 'SirVer/ultisnips'
call plug#end()


"" ----- PLUGIN SETTINGS -----
" Markdown settings
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_strikethrough = 0
let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_auto_insert_bullets = 0
set conceallevel=0

" Snippets
let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<tab>'
let g:UltiSnipsJumpBackwardTrigger='<C-h>'
let g:UltiSnipsSnippetDirectories=["snips"]


"" ----- STATUS LINE -----
highlight clear StatusLine
set laststatus=0
set noruler


"" ----- KEYBINDS -----
" Shift + arrow keys resize splits
nnoremap <S-Up> :resize +2<CR>
nnoremap <S-Down> :resize -2<CR>
nnoremap <S-Left> :vertical resize +2<CR>
nnoremap <S-Right> :vertical resize -2<CR>

" Ctrl + t - new tab
map <silent> <C-t> :tabnew<CR>

" Ctrl + n - next tab
map <silent> <C-n> :tabnext<CR>

" Ctrl + w - close tab
map <silent> <C-w> :tabclose<CR>

" Ctrl + Backspace - delete last word
inoremap <C-H> <C-W>

" F2 - toggle line numbers
nnoremap <silent> <F2> :set nonumber! norelativenumber!<CR>

" F4 - source nvim config
nnoremap <F4> :source ~/.config/nvim/init.vim<CR>

" F5 - clear whitespace
nnoremap <F5> :%s/\s\+$//<CR>

" F8 - enable spellchecking (use 'z=' for correction suggestions)
nnoremap <F8> :setlocal spell! spelllang=en_us<CR>

" Leader bindings

" Set the leader key to ','
let mapleader =","

" Leader + b - next buffer
nnoremap <silent> <leader>b :bn<CR>

" Leader + g - toggle Goyo
nnoremap <silent> <leader>g :Goyo \| set linebreak<CR>

" Leader + z - open the current file's pdf version using zathura
nnoremap <leader>z :w! \| !zathura %:r.pdf &<CR>

" Leader + d - convert to docx using pandoc
nnoremap <leader>d :!pandoc % -s -o %:r.docx --reference-doc=$HOME/.local/pandoc/custom-reference.docx<CR>

" Leader + c - compile to pdf using pandoc with the xelatex engine
nnoremap <leader>c :w! \| !pandoc % -s -o %:r.pdf --pdf-engine=xelatex -V 'mainfont:Times New Roman' -V 'geometry:margin=2cm'<CR>

" Apostrophe bindings

" ' + l - fzf locate
nnoremap 'l :Locate ~/<CR>

" ' + f - fzf in current directory
nnoremap 'f :exe ":Files " . expand("%:h")<CR>

" ' + c - fzf configs
nnoremap 'c :Files ~/.config/<CR>

" ' + s - fzf scripts
nnoremap 's :Files ~/.local/bin/<CR>

" ' + d - fzf documents
nnoremap 'd :Files ~/doc<CR>

" ' + u - fzf uni
nnoremap 'u :Files /mnt/windows/Users/Roli/Desktop/Uni/II.-IV.\ Semester/<CR>

" ' + v - edit nvim config
nnoremap 'v :e ~/.config/nvim/init.vim<CR>


"" ----- QUALITY OF LIFE ------
" Cursor stays relatively in the middle while scrolling
set scrolloff=8

" Show tabs and whitespaces
set list listchars=nbsp:¬,tab:»·,trail:·,extends:>

" Enable undo history file
set undofile

" Recognize filetypes
filetype plugin indent on

" Colorcolumn and text width
" highlight ColorColumn ctermbg=lightgrey guibg=lightgrey
" set colorcolumn=80
" set textwidth=80
" au BufWinEnter *.md let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)

" Tab spaces
set tabstop=4
set shiftwidth=4
set expandtab

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

" Enable wrapping and linebreak
set wrap
set linebreak

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


"" ----- DISABLE ARROW KEYS IN NORMAL MODE-----
noremap <up> :echoerr "USE K INSTEAD"<CR>
noremap <down> :echoerr "USE J INSTEAD"<CR>
noremap <left> :echoerr "USE H INSTEAD"<CR>
noremap <right> :echoerr "USE L INSTEAD"<CR>


"" ----- AUTORUN ON FILESAVE -----
" Run xrdb when Xdefaults or Xresources are updated
autocmd BufWritePost *Xresources,*Xdefaults !xrdb %

" Update binds when sxhkdrc is updated
autocmd BufWritePost *sxhkdrc !pkill -USR1 -x sxhkd
