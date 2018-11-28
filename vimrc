call plug#begin()

Plug 'scrooloose/nerdtree'
Plug 'elixir-lang/vim-elixir'
Plug 'tpope/vim-endwise'
Plug 'eugen0329/vim-esearch'
Plug 'srstevenson/vim-trim-whitespace'

call plug#end()

" Folding for elixir files
autocmd Filetype elixir setlocal foldmethod=expr foldexpr=FoldElixir(v:lnum)

set number
set relativenumber
autocmd vimenter * NERDTree
let NERDTreeShowLineNumbers=1

set directory^=$HOME/.vim/tmp//  "organize .swp files

"Change leader
let mapleader = "\<Tab>"

"Show incomplete commands
set showcmd

"How many lines vim remember
set history=500

set ttyfast

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

"Open CTRL-P plugin
nmap <leader>p :CtrlP<CR>

"Search highlight on/off
map <leader>s :set hls!<CR>

" Elixir investigate
imap <leader>p IO.puts("YOYOYOYO")
imap <leader>i IO.inspect

" Cursor line and column
nmap <leader>l :set cursorline!<Bar>set cursorcolumn!<CR>

" Blank
"nmap <leader>b :set number!<Bar>set relativenumber!<CR>
nmap <leader>n :set number!<CR>

"Close html tags
map <leader>h ?<<CR>vey$p?<<CR>a/<ESC>$a><ESC>?<<CR>i<CR><CR><ESC>k<leader>o

"Jump to line
nmap <Space> G

"Active relativenumber
nmap <leader>r :set relativenumber!<CR>

"Move windows
nmap <leader>mw <C-W>

" Move a line of text
nmap <C-m> mz:m+<cr>`z
nmap <C-n> mz:m-2<cr>`z
vmap <C-m> :m'>+<cr>`<my`>mzgv`yo`z
vmap <C-n> :m'<-2<cr>`>my`<mzgv`yo`z

" Fold documentation in elixir projects
function! FoldElixir(lnum)
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
