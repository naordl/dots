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
Plug 'vimwiki/vimwiki'
Plug 'plasticboy/vim-markdown'
Plug 'tpope/vim-surround'
call plug#end()

" Goyo
let g:goyo_width = 80

" Vimwiki
let g:vimwiki_list = [{'path': '~/Documents/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
let g:vimwiki_markdown_link_ext = 1
let g:vimwiki_table_mappings = 0
let g:vimwiki_hl_headers = 1
let g:vimwiki_url_maxsave = 0
let g:markdown_folding = 0
let g:vimwiki_conceallevel = 0
" Markdown
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0

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
" Conceal
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
set noshowcmd
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

" Goyo
map <leader>r :Goyo \| set bg=light \| hi! ColorColumn ctermbg=235<CR>

" FZF
" Buffers
nnoremap <silent> <leader>b :Buffers<CR>
" Locate
nnoremap <silent> <leader>g :Locate ~/<CR>
" Files
nnoremap <silent> <leader>f :exe ":Files " . expand("%:h")<CR>
" Documents
nnoremap <silent> <leader>D :Files ~/Documents<CR>

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
" Navigate splits
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

" SNIPPETS
" Markdown
autocmd FileType markdown inoremap ;<Space> <ESC>f<"_c4l
autocmd FileType markdown inoremap ;i **<Space><++><ESC>5hi
autocmd FileType markdown inoremap ;b ****<Space><++><ESC>6hi
autocmd FileType markdown inoremap ;s ~~~~<Space><++><ESC>6hi
autocmd FileType markdown inoremap ;l [](<++>)<Space><++><ESC>F[a
autocmd FileType markdown inoremap ;I ![](<++>)<Space><++><ESC>F[a
autocmd FileType markdown inoremap ;d <ESC>:put =strftime('%d.%m.%Y')<CR>i<Backspace><ESC>A<Space>
autocmd FileType markdown inoremap ;t <ESC>:put =strftime('%I:%M%P')<CR>i<Backspace><ESC>A<Space>

" AUTO COMMANDS
" Disable autocommenting
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
" Autocd into the directory that the file is in
autocmd BufEnter * silent! lcd %:p:h
" Autodelete all trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e
" Textwidth and colorcolumn for markdown files
autocmd FileType markdown setlocal textwidth=80
autocmd FileType markdown set colorcolumn=+1
autocmd FileType markdown hi! ColorColumn ctermbg=256
autocmd FileType markdown hi! OverLength ctermfg=darkred
autocmd FileType markdown match OverLength /\%>80v.\+/
" Run xrdb when writing to xdefaults or xresources
autocmd BufWritePost *xresources,*xdefaults !xrdb %
" Update binds when writing to sxhkdrc
autocmd BufWritePost *sxhkdrc !pkill -USR1 -x sxhkd
" Update shortcuts when writing to shortcuts file
autocmd BufWritePost ~/.local/shortcuts !shortcutgen
" Update rc.conf when writing to rc_base.conf
autocmd BufWritePost ~/.config/ranger/rc_base.conf !shortcutgen
" Compile suckless programs when writing to their header files
autocmd BufWritePost ~/Repos/dwm/config.h !cd ~/Repos/dwm/ && sudo make clean install
autocmd BufWritePost ~/Repos/dmenu/config.h !cd ~/Repos/dmenu/ && sudo make clean install
autocmd BufWritePost ~/Repos/st/config.h !cd ~/Repos/st/ && sudo make clean install
autocmd BufWritePost ~/Repos/slock/config.h !cd ~/Repos/slock/ && sudo make clean install
autocmd BufWritePost ~/Repos/dwmblocks/blocks.h !cd ~/Repos/dwmblocks/ && sudo make clean install && killall -q dwmblocks; setsid -f dwmblocks &
