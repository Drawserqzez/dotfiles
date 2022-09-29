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
    Plug 'vim-syntastic/syntastic'
    Plug 'prabirshrestha/asyncomplete.vim'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() }}
    Plug 'posva/vim-vue'
    Plug 'mattn/emmet-vim'

    " Omnisharp

    " TODO: Follow this tutorial or something 
    " https://rudism.com/coding-csharp-in-neovim/ 
    " Vim is very cool I like it a lot :)

    call plug#end()
" }}}


": MAPPINGS {{{
    nnoremap ö ^
    nnoremap ä $
    vnoremap ö ^
    vnoremap ä $

    nnoremap J 5j
    nnoremap K 5k
    nnoremap H 10h
    nnoremap L 10l

    nnoremap gs <C-w>
    nnoremap + <C-w>+
    nnoremap - <C-w>-

    inoremap jkl <Esc>
    tnoremap jkl <C-\><C-n>

    nnoremap gm :NERDTreeToggle<CR>
    nnoremap gn :NERDTreeFocus<CR>

    nnoremap gx :call JsonBeautify()<CR>
    nnoremap gfz :FZF<CR>

" }}}

" asyncomplete mappings {{{ 
    " tab completion
    inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
    inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
    inoremap <expr> <cr> pumvisible() ? asyncomplete#close_popup() : "\<cr>"

    " force refresh preview
    imap <c-space> <Plug>(asyncomplete_force_refresh)

    
    " autoclose preview window on completion
    autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
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

    " airline settings
    let g:airline_powerline_fonts = 1
    let g:airline#extensions#tabline#enabled = 1

    " Syntastic setup
    "
    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*

    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 1
    let g:syntastic_auto_loc_list = 1
    let g:syntastic_check_on_open = 1
    let g:syntastic_check_on_wq = 1
    let g:syntastic_javascript_checkers = ['eslint']
    let g:syntastic_javascript_eslint_exe = 'npm run lint --'
" }}}
"
" Omnisharp settings {{{
    autocmd FileType cs nmap <silent> <buffer> gr <Plug>(omnisharp_rename)
    autocmd FileType cs nmap <silent> <buffer> gd <Plug>(omnisharp_go_to_definition)
    autocmd FileType cs nmap <silent> <buffer> gh <Plug>(omnisharp_documentation)

" }}}

