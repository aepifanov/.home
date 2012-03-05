
filetype off
silent! call pathogen#helptags()
silent! call pathogen#runtime_append_all_bundles() 
filetype plugin indent on

if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

colorscheme andrey
syntax      enable
filetype    plugin indent on

"set encoding=utf-8
"set fileencoding=utf-8
"set fileencodings=utf-8,cp1251

set number                        " Enable line number
set showcmd                       " Display incomplete commands.
set showmode                      " Display the mode you're in.
set backspace=indent,eol,start    " Intuitive backspacing.
set hidden                        " Handle multiple buffers better.
set wildmenu                      " Enhanced command line completion.
set wildmode=list:longest         " Complete files like a shell.
set ignorecase                    " Case-insensitive searching.
set smartcase                     " But case-sensitive if expression contains a capital letter.
set number                        " Show line numbers.
set ruler                         " Show cursor position.
set incsearch                     " Highlight matches as you type.
set hlsearch                      " Highlight matches.
set nowrap                        " Turn on line wrapping.
set scrolloff=3                   " Show 3 lines of context around the cursor.
set title                         " Set the terminal's title
set visualbell                    " No beeping.
set autoread                      " auto reread file 
set hidden
set completeopt=longest,menuone   " enable auto complete ?
set browsedir=buffer              " set dir at current buffer(file)
set shiftwidth=4                  " size auto indent
set tabstop=4                     " size tabs
set softtabstop=4
set smarttab
set expandtab                     " change tabs on space
set foldenable                    " folding enable
set fdm=manual                    " manual folding
set foldopen=all                  " auto open folding
set nobackup
set nowritebackup
set noswapfile
set laststatus=2                  " Show the status line all the time



" Useful status information at bottom of screen
set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\ %{exists('*CapsLockStatusline')?CapsLockStatusline():''}%=%-16(\ %l,%c-%v\ %)%P

cabbr <expr> %% substitute(expand('%:p:h'), getcwd() . '/', '', '')

let g:ctags_regenerate=0 
let Tlist_Ctags_Cmd='"ctags"' 


"    set normal mode
map  <C-l>           :noh<cr>

"    explorer
map  <F1>            :NERDTree<cr>
imap <F1>       <esc>:NERDTree<cr>

"    save file
map  <F2>            :w<cr>
imap <F2>       <esc>:w<cr>

"    cscope find global
map  <F3>            :cs f g <c-r>=expand("<cword>")<cr><cr> 
imap <F3>       <esc>:cs f g <c-r>=expand("<cword>")<cr><cr>

"    cscope find global
map  <F4>            :cs f c <c-r>=expand("<cword>")<cr><cr> 
imap <F4>       <esc>:cs f c <c-r>=expand("<cword>")<cr><cr>

"    list buffers
map  <F5>            :BufExplorer<cr>
imap <F5>       <esc>:BufExplorer<cr>

"    next buffer
map  <F6>            :bn<cr>
imap <F6>       <esc>:bn<cr>

"    prev buffer
map  <F7>            :bp<cr>
imap <F7>       <esc>:bp<cr>

"    del buffer
map  <F8>            :bd<cr>
imap <F8>       <esc>:bd<cr>

"    list tags
map  <F9>            :TlistToggle<cr>
imap <F9>       <esc>:TlistToggle<cr>
"
""
map  <F10>           :!ctags -x %<cr>
imap  <F10>     <esc>:!ctags -x %<cr>
"
""
"map  <F11>
"imap <F11>
"

"    save file
map  <F12>           :wa<cr>
imap <F12>      <esc>:wa<cr>

map  <C-j>           <C-e>
map  <C-k>           <C-y>



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") |   exe "normal! g`\"" | endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("cscope")
    " use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
    set cscopetag
    
    " show msg when any other cscope db added
    "set cscopeverbose
    
    if filereadable("cscope.out")
        cs add cscope.out
        " else add database pointed to by environment
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
endif " has("cscope")

