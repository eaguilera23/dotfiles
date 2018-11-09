execute pathogen#infect()
syntax on
filetype plugin indent on
set number
set relativenumber
autocmd vimenter * NERDTree
let NERDTreeShowLineNumbers=1

set directory^=$HOME/.vim/tmp//  "organize .swp files
command Cp :CtrlP

"Change leader
let mapleader = "\<Tab>"

"Show incomplete commands
set showcmd

"How many lines vim remember
set history=500

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

"save and close window
nmap <leader>w :w<CR>
nmap <leader>W :wq<CR>

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

"Quit window
nmap Q :q<CR>

"Open CTRL-P plugin
nmap <leader>p :CtrlP<CR>

"Search
map <leader>s :set hls!<CR>

" Elixir investigate
imap <leader>y IO.puts("YOYOYOYO")
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

"Setup yaml files
"https://www.vim.org/scripts/script.php?script_id=739
au BufNewFile,BufRead *.yaml,*.yml so ~/.vim/yaml.vim
