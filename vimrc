let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'

" Plugin Management
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin()

" Plugins
Plug 'scrooloose/nerdtree'
Plug 'elixir-lang/vim-elixir'
Plug 'tpope/vim-endwise'
Plug 'eugen0329/vim-esearch' " To make this work, install the silver surfer searcher (ag)
Plug 'srstevenson/vim-topiary' " Remove whitespace
Plug 'bling/vim-bufferline'
Plug 'previm/previm'
Plug 'mhinz/vim-mix-format'
Plug 'gabrielelana/vim-markdown'
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'vim-utils/vim-ruby-fold'
Plug 'wesQ3/vim-windowswap'
Plug 'gcmt/taboo.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'rhysd/vim-syntax-codeowners'
Plug 'hashivim/vim-terraform'
Plug 'vim-python/python-syntax'
Plug 'OmniSharp/omnisharp-vim'

call plug#end()

" Colors Configuration
"""""""""" COLORS """""""""""""""
" https://upload.wikimedia.org/wikipedia/commons/1/15/Xterm_256color_chart.svg

" General Settings
set nocompatible
set number
set relativenumber
set tabstop=2
set shiftwidth=2
set expandtab
set splitright
set splitbelow
set lazyredraw
set history=500
set ttyfast
set showcmd
set undodir=~/.vim/undo-dir
set undofile

" Undo Directory Setup
if !isdirectory($HOME."/.vim/undo-dir")
    call mkdir($HOME."/.vim/undo-dir", "p", 0700)
endif

" Organize .swp files
if !isdirectory($HOME . "/.vim/tmp")
    call mkdir($HOME . "/.vim/tmp", "p", 0700)
endif
set directory^=$HOME/.vim/tmp//

" Folding Configuration
set nofoldenable
autocmd Filetype elixir setlocal foldmethod=expr foldexpr=FoldElixir(v:lnum)

" Syntax Highlighting
syntax on
filetype plugin indent on

" Filetype Specific Settings
au BufRead,BufNewFile *.avsc setlocal filetype=avro-idl
au BufRead,BufNewFile *.md setlocal textwidth=80
au BufRead .zshrc-custom setfiletype zsh
autocmd BufRead,BufNewFile *.tpl set filetype=yaml
hi ColorColumn ctermbg=DarkGrey guibg=DarkGrey
au BufRead,BufNewFile COMMIT_EDITMSG setlocal colorcolumn=73

" NERDTree Configuration
let filetypeToIgnore = ['gitcommit', 'zsh', 'blank']
autocmd vimenter * if index(filetypeToIgnore, &ft) < 0 | NERDTree
let NERDTreeShowLineNumbers=1
let g:NERDTreeNodeDelimiter = "\u00a0" " Bug that makes ^G to appear
if isdirectory(expand(".git"))
  let g:NERDTreeBookmarksFile = '.git/.nerdtree-bookmarks'
endif

" Previm Configuration
let g:previm_open_cmd = 'open -a Safari'

" Esearch Configuration
let g:esearch = {
  \ 'adapter':          'ag',
  \ 'backend':          'vim8',
  \ 'out':              'win',
  \ 'batch_size':       1000,
  \ 'use':              ['visual', 'hlsearch'],
  \ 'default_mappings': 1,
  \}
let g:esearch.name = '[esearch]'
let g:esearch.win_new = {esearch -> esearch#buf#goto_or_open(esearch.name, 'vne')}
let g:esearch.live_update = 0

" Python Configuration
let g:python_highlight_all = 1

" Key Mappings
" Change leader
let mapleader = "\<Tab>"

" Basic Key Mappings
nmap <F12> :tabe ~/.vimrc<CR>
nmap <F10> :source ~/.vimrc<CR>
nmap <F9> :! ~/dotfiles/update.sh<CR>
nmap <F1> :NERDTreeToggle<CR>
nmap <F2> :SessionSave<CR>
nmap <F3> :SessionLoad<CR>
nmap <leader>o ddO
nmap <leader>t :tabnew<CR><F1>
nmap <leader>q :tabclose<CR>
nmap <leader>1 1gt
nmap <leader>2 2gt
nmap <leader>3 3gt
nmap <leader>4 4gt
nmap <C-l> <C-w>l
nmap <C-k> <C-w>k
nmap <C-j> <C-w>j
nmap <C-h> <C-w>h
nmap <Space> G
nmap <leader>r :set relativenumber!<Bar>set number!<CR>
nmap <leader>mw <C-W>
nmap <leader>n :bnext<CR>
nmap <leader>b :bprevious<CR>
nmap <leader>x :SmartBdelete<CR>
nmap <leader>* :%s/<c-r><c-w>//g<left><left>
nmap <leader># ^i#<Esc>
vmap <leader>3 I#<Esc>
nmap <leader>, :b<SPACE>

" Resizing the Window
nmap ˙ :vertical res +5<CR>
nmap ¬ :vertical res -5<CR>
nmap <leader>k :res +5<CR>
nmap <leader>j :res -5<CR>

" Commenting Made Easy
vmap <leader>3 I#<Esc>

" AsyncRun Configuration
let g:asyncrun_open = 8 " Open the quickfix window
nmap <leader>ar :AsyncRun -mode=term -rows=20
nmap <leader>mt <leader>ar -focus=0 mix test %:p<CR>
nmap <leader>gd <leader>ar git diff<CR>

" Insert Date
nmap <leader>d :r! date<CR>

" Window Swapping
let g:windowswap_map_keys = 0 " prevent default bindings
nnoremap <silent> <leader>ww :call WindowSwap#EasyWindowSwap()<CR>
nnoremap <silent> <leader>wy :call WindowSwap#MarkWindowSwap()<CR>
nnoremap <silent> <leader>w :call WindowSwap#DoWindowSwap()<CR>

" Count Occurrences of the Word
command -nargs=1 Count :%s/<args>//gn

" Paste into the Clipboard the Current Buffer's File Path
command CopyPath :let @* = expand("%")

" Session Management
command SessionSave :call FuncSaveSession()
command SessionLoad :call FuncLoadSession()

function FuncSaveSession()
  let session_path = "~/.vim/sessions/"
  let current_directory = getcwd()
  let session_name = session_path . substitute(current_directory, "/", "_", "g") . ".vim"
  echo session_name
  execute "mks!" . session_name
endfunction

function FuncLoadSession()
  let session_path = "~/.vim/sessions/"
  let current_directory = getcwd()
  let session_name = session_path . substitute(current_directory, "/", "_", "g") . ".vim"
  echo session_name
  execute "source" . session_name
endfunction

" Fold Documentation in Elixir Projects
function! FoldElixir(lnum)
  if &ft =~ '_test.exs'
    return
  endif

  let line=getline(a:lnum)
  if line=~ '@moduledoc """'
    return 'a1'
  elseif line =~ '@doc """'
    return 'a1'
  elseif line =~ '"""'
    return 's1'
  else
    return '='
  endif
endfunction

" C# Mappings
augroup csharp_mappings
    autocmd!
    autocmd FileType cs nnoremap <buffer> <C-o><C-i> :OmniSharpGotoImplementation<CR>
augroup END

" Function to Delete the Current Buffer
function! SmartBdelete()
  " Check if NERDTree is open
  if exists("t:NERDTreeBufName")
    " Get the current buffer number
    let l:cur_buf = bufnr('%')
    " Open a new empty buffer
    enew
    " Delete the previously active buffer
    execute 'bdelete' l:cur_buf
  else
    " If NERDTree is not open, simply delete the buffer
    bdelete
  endif
endfunction
