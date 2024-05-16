set nocompatible                " Vim over Vi
filetype plugin indent on       " activates filetype detection
syntax on                       " enables syntax highlighting

set autoindent                  " automatic indenting
set background=dark             " color schema for dark background
set backspace=indent,eol,start  " backspace on ident, end of line and start
set clipboard+=unnamedplus      " use y and p to copy and paste to the 'global' buffer
set cursorline                  " highlight cursor line
set encoding=utf-8              " sets the character encoding used
set expandtab                   " convert tab into spaces
set fileencoding=utf-8          " sets the file encoding
set fileformat=unix             " this gives the <EOL> of the current buffer
set history=5000                " remember last 5000 commands
set ic!                         " ignore case for searching
set nobackup                    " no default backup
set nowrap                      " no wrapping
set number relativenumber       " show line number
set ruler                       " shows a little position information at the bottom of the window
set scrolloff=3                 " space between cursor and terminal bottom
set shellcmdflag=-ic            " flag passed to the shell to execute "!" and ":!" commands
set shiftwidth=4                " number of spaces to use for each step of (auto)indent
set showmatch                   " highlight matching braces
set sidescrolloff=3             " space between cursor and terminal side
set smarttab                    " smart tabs
set tabstop=4                   " tab width
set termencoding=utf-8          " encoding used for the terminal
set termguicolors               " enable true colors
set textwidth=130               " maximum width of text that is being inserted
set title                       " sets terminal title
set undodir=~/.vim/undodir      " define the undo directory
set undofile                    " enable persistent undo
set undolevels=1500             " how many times the user can undo
set visualbell                  " use visual bell instead of beeping
set wildmenu                    " command-line completion operates in an enhanced mode
set wildmode=longest:full,full  " completion mode

