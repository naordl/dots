" PLUGINS
" Download vim-plug
if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
    echo "Downloading junegunn/vim-plug to manage plugins."
    silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
    silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
    autocmd VimEnter * PlugInstall
endif
" Call plugins
call plug#begin()
Plug 'ap/vim-css-color'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/fzf.vim'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'dkarter/bullets.vim'
Plug 'reedes/vim-pencil'
Plug 'tpope/vim-surround'
Plug 'SirVer/ultisnips'

Plug 'arcticicestudio/nord-vim'
Plug 'vim-airline/vim-airline'
call plug#end()

" Colorscheme (plugin)
augroup nord-theme-overrides
    autocmd!
    autocmd ColorScheme nord highlight Comment ctermfg=244
    autocmd ColorScheme nord highlight Visual ctermbg=240
augroup END

colorscheme nord

" Goyo
let g:goyo_width = 80
" Markdown
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_strikethrough = 1
let g:vim_markdown_no_extensions_in_markdown = 1
let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_new_list_item_indent = 0
" Bullets
let g:bullets_delete_last_bullet_if_empty = 1
let g:bullets_enabled_file_types = [ 'markdown' ]
" Pencil
let g:pencil#wrapModeDefault = 'soft'
autocmd FileType markdown call pencil#init()
" Snippets
let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<tab>'
let g:UltiSnipsJumpBackwardTrigger='<shift-tab>'
let g:UltiSnipsSnippetDirectories=["snips"]

" BASICS
" Colors
" set termguicolors
set background=dark
" Cursor
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"
set ttimeout
set ttimeoutlen=1
set ttyfast
" Mouse
set mouse=a
" Hidden
set hidden
" Scrolling
set scrolloff=6
" Empty newlines
set fillchars=eob:\ ,
" Hide intro message
set shortmess+=I
" Search
set nohlsearch
set incsearch
" Clipboard
set clipboard+=unnamedplus
" Tabs
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
" Indentation
set autoindent
" Concealing
set conceallevel=0
set concealcursor=n
" Encoding
set encoding=utf-8
set nocompatible
filetype plugin indent on
" Syntax highlighting
syntax on
" Line numbers
set number relativenumber
" Autocomplete
set wildmode=longest,list,full
" Case insensitivity
set ignorecase
set smartcase
" Wrapping and linebreak
set wrap
set linebreak
" Splits
set splitbelow splitright
" Undo
set undofile
" Netrw history
let g:netrw_dirhistmax = 0
" Status line
highlight clear StatusLine
set laststatus=0
set noruler
set showcmd
set noshowmode

" REMAPS
" Leader
let mapleader=","
" Source config
nnoremap <leader>S :source ~/.config/nvim/init.vim<CR>
" Spellchecking
nnoremap <leader>s :setlocal spell! spelllang=en_us<CR>
" Edit config
nnoremap <leader>v :e ~/.config/nvim/init.vim<CR>
" Edit todo list
nnoremap <leader>td :e ~/Documents/Notes/raw/todo.md<CR>

" GOYO
" Toggle
map <leader>r :Goyo \| set bg=dark \| hi! ColorColumn ctermbg=235<CR>

" MARKDOWN
" Table of contents
nnoremap <leader>toc :Toc<CR>
" Table format
nnoremap <leader>tf :TableFormat<CR>

" FZF
" Buffers
nnoremap <silent> <leader>b :Buffers<CR>
" Locate
nnoremap <silent> <leader>g :Locate ~/<CR>
" Files
nnoremap <silent> <leader>f :exe ":Files " . expand("%:h")<CR>
" Uni
nnoremap <silent> <leader>u :Files ~/Documents/Uni<CR>

" CONVERSION
" Zathura current file
nnoremap <leader>z :w! \| !zathura "%:r".pdf &<CR><CR>
" Convert to docx using pandoc
nnoremap <leader>d :!pandoc "%" -s -o "%:r".docx --reference-doc=$HOME/.local/pandoc/custom-reference.docx<CR>
" Compile to pdf using pandoc
nnoremap <leader>c :w! \| !pandoc "%" -s -o "%:r".pdf --pdf-engine=xelatex -V 'mainfont:Times New Roman' -V 'geometry:margin=1in'<CR>

" Disable arrow keys
noremap <up> :echoerr "USE K INSTEAD!"<CR>
noremap <down> :echoerr "USE J INSTEAD!"<CR>
noremap <left> :echoerr "USE H INSTEAD!"<CR>
noremap <right> :echoerr "USE L INSTEAD!"<CR>
" Navigate splits easier
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
" Resize splits
nnoremap <silent> <S-Up> :resize +2<CR>
nnoremap <silent> <S-Down> :resize -2<CR>
nnoremap <silent> <S-Left> :vertical resize +2<CR>
nnoremap <silent> <S-Right> :vertical resize -2<CR>
" S for global substitution
nnoremap S :%s///g<Left><Left><Left>
" Delete previous word
inoremap <C-H> <C-W>

" AUTO COMMANDS
" Disable autocommenting
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
" Autocd into the directory that the file is in
autocmd BufEnter * silent! lcd %:p:h
" Jump to last position when reopening file
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
" Autodelete all trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e
" Textwidth and colorcolumn for markdown files
" autocmd FileType markdown setlocal textwidth=80
" autocmd FileType markdown set colorcolumn=+1
" autocmd FileType markdown hi! ColorColumn ctermbg=256
" autocmd FileType markdown hi! OverLength ctermfg=darkred
" autocmd FileType markdown match OverLength /\%>80v.\+/
" Always treat *.md as markdown
autocmd BufEnter,BufRead,BufNewFile *.md set filetype=markdown
" Enable spellchecking in markdown
autocmd BufEnter,BufRead,BufNewFile *.md setlocal spell
autocmd BufEnter,BufRead,BufNewFile *.md setlocal spelllang=en_us
" -> turns to → in markdown
" inoremap -> →
" Run xrdb when writing to xdefaults or xresources
autocmd BufWritePost *xresources,*xdefaults !xrdb %
" Update binds when writing to sxhkdrc
autocmd BufWritePost *sxhkdrc !pkill -USR1 -x sxhkd
" Update shortcuts when writing to shortcuts file
autocmd BufWritePost ~/.local/shortcuts !shortcutgen
" Update rc.conf when writing to rc_base.conf
autocmd BufWritePost ~/.config/ranger/rc_base.conf !shortcutgen
" Compile suckless programs when writing to their header files
autocmd BufWritePost ~/.local/src/dwm/config.h !cd ~/.local/src/dwm/ && sudo make clean install
autocmd BufWritePost ~/.local/src/dmenu/config.h !cd ~/.local/src/dmenu/ && sudo make clean install
autocmd BufWritePost ~/.local/src/st/config.h !cd ~/.local/src/st/ && sudo make clean install
autocmd BufWritePost ~/.local/src/slock/config.h !cd ~/.local/src/slock/ && sudo make clean install
autocmd BufWritePost ~/.local/src/dwmblocks/blocks.h !cd ~/.local/src/dwmblocks/ && sudo make clean install && killall -q dwmblocks; setsid -f dwmblocks &
