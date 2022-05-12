" PLUGIN ------------ {{{
    call plug#begin('~/.vim/plugged')

    Plug 'dense-analysis/ale'
    Plug 'cocopon/iceberg.vim'
    Plug 'preservim/nerdtree'
    Plug 'OmniSharp/omnisharp-vim'
    Plug 'razzmatazz/csharp-language-server'
    Plug 'ryanoasis/vim-devicons'
    Plug 'vim-airline/vim-airline'
    Plug 'jlcrochet/vim-razor'
    Plug 'OrangeT/vim-csharp'
    Plug 'neovim/nvim-lspconfig'
    Plug 'udalov/kotlin-vim'
    Plug 'maksimr/vim-jsbeautify'
    Plug 'catppuccin/nvim', {'as': 'catppuccin'}

    " TODO: Follow this tutorial or something 
    " https://rudism.com/coding-csharp-in-neovim/ 
    " Vim is very cool I like it a lot :)

    call plug#end()
" }}}


" MAPPINGS ------------------------------------------------------------------------------- {{{
    nnoremap ö ^
    nnoremap ä $
    vnoremap ö ^
    vnoremap ä $

    nnoremap J 5j
    nnoremap K 5k
    nnoremap H 10h
    nnoremap L 10l

    nnoremap gs <C-w>

    inoremap jkl <Esc>
    tnoremap jkl <C-\><C-n>

    nnoremap gm :NERDTreeToggle<CR>
    nnoremap gn :NERDTreeFocus<CR>

    nnoremap gx :call JsonBeautify()<CR>
" }}}

" SETTINGS ----------------------------------------------------------------------------------------------------- {{{

"    autocmd VimEnter * NERDTree | wincmd p
"    set background=dark
    colorscheme catppuccin
    set tabstop=4
    set shiftwidth=4
    set expandtab

    set nocompatible
    filetype on
    filetype plugin on
    filetype indent on
    syntax on
    set number
    set cursorline

    set nobackup
    set scrolloff=10
    set nowrap
    set incsearch
    set ignorecase
    set smartcase
    set showcmd
    set showmode
    set hlsearch
    set wildmenu
    set wildmode=list:longest
    set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

    " Omnisharp setup
" }}}

