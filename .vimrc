" PLUGIN ------------ {{{
    call plug#begin('~/.vim/plugged')

    Plug 'cocopon/iceberg.vim'
    Plug 'preservim/nerdtree'
    Plug 'ryanoasis/vim-devicons'
    Plug 'vim-airline/vim-airline'
    Plug 'maksimr/vim-jsbeautify'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() }}
    Plug 'mattn/emmet-vim'
    Plug 'neoclide/coc.nvim', { 'branch': 'release' }
    Plug 'sheerun/vim-polyglot'
    Plug 'rebelot/kanagawa.nvim'

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

    nnoremap gp :sp<CR>
    nnoremap gv :vsp<CR>
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
"
    nnoremap trm :sp<CR> <C-w>j :ter<CR>
    nnoremap vtrm :vsp<CR> <C-w>l :ter<CR>

" coc.nvim mappings {{{
"
    " We wanna refresh lsp often
    set updatetime=300

    inoremap <silent><expr> <TAB>
                \ coc#pum#visible() ? coc#pum#next(1) : 
                \ CheckBackspace() ? "\<Tab>" : 
                \ coc#refresh()
    inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

    inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

    function! CheckBackspace() abort 
        let col = col('.') - 1
        return !col || getline('.')[col - 1] =~# '\s'
    endfunction

    if has('nvim')
        inoremap <silent><expr> <c-space> coc#refresh()
    endif

    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> grf <Plug>(coc-references)
    nmap <silent> grn <Plug>(coc-rename)

    autocmd CursorHold * silent call CocActionAsync('highlight')
" }}}

" SETTINGS ----------------------------------------------------------------------------------------------------- {{{

"    autocmd VimEnter * NERDTree | wincmd p
"    set background=dark
    colorscheme iceberg
    "uolorscheme kanagawa
    set tabstop=4
    set shiftwidth=4
    set expandtab

    set nocompatible
    filetype on
    "filetype plugin on
    "filetype indent on
    syntax on
    set number
    set cursorline

    " sane splits
    set splitbelow
    set splitright

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

