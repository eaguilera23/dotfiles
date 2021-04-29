call plug#begin()

"Plug 'https://github.com/leafgarland/typescript-vim.git'
Plug 'scrooloose/nerdtree'
Plug 'elixir-lang/vim-elixir'
Plug 'tpope/vim-endwise'
Plug 'eugen0329/vim-esearch' "To make this work, install the silver surfer searcher (ag)
Plug 'srstevenson/vim-trim-whitespace'
Plug 'bling/vim-bufferline'
Plug 'previm/previm'
Plug 'mhinz/vim-mix-format'
"Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'gabrielelana/vim-markdown'
Plug 'skywind3000/asyncrun.vim'
"Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'

call plug#end()

"Change leader
let mapleader = "\<Tab>"

" Folding for elixir files
autocmd Filetype elixir setlocal foldmethod=expr foldexpr=FoldElixir(v:lnum)

"wrap text for markdown
au BufRead,BufNewFile *.md setlocal textwidth=120

" Delimit git commits for its content
" it is meant to be used with the command `git commit -m "Title" -e
hi ColorColumn ctermbg=DarkGrey guibg=DarkGrey
au BufRead,BufNewFile COMMIT_EDITMSG setlocal colorcolumn=73

" Basic config
"filetype plugin indent on
set number
set relativenumber
set tabstop=2
set shiftwidth=2
set expandtab

" Let's save undo info!
if !isdirectory($HOME."/.vim/undo-dir")
    call mkdir($HOME."/.vim/undo-dir", "p", 0700)
endif
set undodir=~/.vim/undo-dir
set undofile

ab eins IO.inspect
ab eput IO.puts("
ab elog Logger.info("

" Automatically open NERDTree unless file is on `filetypeToIgnore`
let filetypeToIgnore = ['gitcommit']
autocmd vimenter * if index(filetypeToIgnore, &ft) < 0 | NERDTree

let NERDTreeShowLineNumbers=1
let g:NERDTreeNodeDelimiter = "\u00a0" " Bug that makes ^G to appear

if isdirectory(expand(".git"))
  let g:NERDTreeBookmarksFile = '.git/.nerdtree-bookmarks'
endif

let g:previm_open_cmd = 'open -a Safari'

let g:esearch = {
  \ 'adapter':          'ag',
  \ 'backend':          'vim8',
  \ 'out':              'win',
  \ 'batch_size':       1000,
  \ 'use':              ['visual', 'hlsearch'],
  \ 'default_mappings': 1,
  \}

"organize .swp files
if !isdirectory($HOME . "/.vim/tmp")
    call mkdir($HOME . "/.vim/tmp", "p", 0700)
endif

set directory^=$HOME/.vim/tmp//

"""""""""""""""""""
""AIRLINE""""""""""
let g:airline#extensions#tabline#enabled = 1
"let g:airline_powerline_fonts = 1
""let g:airline_theme='powerlineish'
""let g:airline#extensions#syntastic#enabled = 1
"set laststatus=2
""""""""""""""""""""""""""""

" No Vi compatibility
set nocompatible

"Show incomplete commands
set showcmd

" redraw only when needed
set lazyredraw

"How many lines vim remember
set history=500

" always show statusline (even with only single window)
set laststatus=2

set ttyfast

" visual autocomplete for command menu
set wildmenu

" Search down into subfolders
" Provides tab-completion for all file-related tasks
set path=$PWD/**
set wildignore+=*/deps/*
set wildignore+=*/node_modules/*
set wildignore+=*/dist/*
set wildignore+=*/support/*

" Create the `tags` file (may need to install ctags first)
command! MakeTags !ctags -R --exclude=.git --exclude=node_modules --exclude=deps

" When wrapped lines, don't skip the fake line
nmap j gj
nmap k gk

"Open this file
nmap <F12> :tabe ~/.vimrc<CR>
nmap <F10> :source ~/.vimrc<CR>
nmap <F9> :! ~/dotfiles/update.sh<CR>

"Toggel NERDTree
nmap <F1> :NERDTreeToggle<CR>

"Let auto identation put cursor where it should be
nmap <leader>o ddO

"open tab with nerdtree
nmap <leader>t :tabnew<CR><F1>

"close tab
nmap <leader>q :tabclose<CR>

"Move around tabs
nmap <leader>1 1gt
nmap <leader>2 2gt
nmap <leader>3 3gt
nmap <leader>4 4gt

"Move around panes
nmap <C-l> <C-w>l
nmap <C-k> <C-w>k
nmap <C-j> <C-w>j
nmap <C-h> <C-w>h

"Move to next capital letter
nmap <leader>w /\u<CR>
"Change word until next capital letter
nmap <leader>cw v/\u<CR>hc

"Quit window and delete buffer
nmap Q :q<CR>

" Move to buffer
nmap , :b

"Open CTRL-P plugin
nmap <leader>p :CtrlP<CR>

"Search highlight on/off
map <leader>s :set hls!<CR>

" Elixir investigate
nmap <C-P> iIO.inspect<Esc>

" Cursor line and column
nmap <leader>l :set cursorline!<Bar>set cursorcolumn!<CR>

" Blank
"nmap <leader>b :set number!<Bar>set relativenumber!<CR>
"nmap <leader>n :set number!<CR>

"Close html tags
map <leader>h ?<<CR>vey$p?<<CR>a/<ESC>$a><ESC>?<<CR>i<CR><CR><ESC>k<leader>o

"Jump to line
nmap <Space> G

"Active relativenumber
nmap <leader>r :set relativenumber!<Bar>set number!<CR>

"Move windows
nmap <leader>mw <C-W>

" Move a line of text
nmap <C-m> mz:m+<cr>`z
nmap <C-n> mz:m-2<cr>`z
vmap <C-m> :m'>+<cr>`<my`>mzgv`yo`z
vmap <C-n> :m'<-2<cr>`>my`<mzgv`yo`z

" Buffer actions
nmap <leader>n :bnext<CR>
nmap <leader>b :bprevious<CR>
nmap <leader>x :bdelete<CR>

" Resizing the window
nmap ≥ :vertical res +5<CR>
nmap ≤ :vertical res -5<CR>
nmap <leader>k :res +5<CR>
nmap <leader>j :res -5<CR>

" Replace word under cursor
nmap <leader>* :%s/<c-r><c-w>//g<left><left>

" Commenting made easy
nmap <leader># ^i#<Esc>
vmap <leader>3 I#<Esc>

"" AsyncRun
let g:asyncrun_open = 8 " Open the quickfix window

" common async run command
nmap <leader>ar :AsyncRun -mode=term -rows=20

" async run mix test
nmap <leader>mt <leader>ar -focus=0 mix test %:p<CR>

" async run git diff
nmap <leader>gd <leader>ar git diff<CR>

" Fold documentation in elixir projects
function! FoldElixir(lnum)
  if &ft =~ '_test.exs'
    return
  endif

	let line=getline(a:lnum)
	if line=~ '@moduledoc """'
		"echo "yes"
		return 'a1'
	elseif line =~ '@doc """'
		return 'a1'
	elseif line =~ '"""'
		return 's1'
	else
		return '='
	endif
endfunction

"Setup yaml files
"https://www.vim.org/scripts/script.php?script_id=739
"au BufNewFile,BufRead *.yaml,*.yml so ~/.vim/yaml.vim
