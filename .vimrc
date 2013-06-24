" Variables initialization {{{
let mapleader = ","
" Disables match paren from the pi_paren standard plugin
let g:loaded_matchparen = 1
" }}}

" User functions {{{
function! ToggleActiveMouse()
    if &mouse == "nv"
        set mouse=
        echo "Mouse is off"
    else
        set mouse=nv
        echo "Mouse is on"
    endif
endfunction

function! TogglePaste()
    set invpaste
    echo &paste == "1" ? "Set paste called" : "Set nopaste called"
endfunction

" This can conflict with the default mappings provided by snipmate.
" See the after directory in .vim/bundle/snipMate/after
function! SuperCleverTab()
    if strpart(getline('.'), 0, col('.') - 1) =~ '^\s*$'
        return "\<Tab>"
    elseif pumvisible()
        return "\<c-n>"
    else
        if &omnifunc != ''
            return "\<C-X>\<C-O>"
        elseif &dictionary != ''
            return "\<C-K>"
        else
            return "\<C-N>"
        endif
    endif
endfunction
" }}}

" General options {{{

" 'compatible' is not set
set nocompatible
set incsearch

" Tell vim to look for these directories
" when doing gf :find , see :h path
set path+=lib,lib/DM,lib/DM/DBObject,src,views

" Useful for jumps
set tags=~/.vim/tags/dailymotion

set complete-=t " Don't look for tags when completing
set complete-=i " Don't look for included files
set termencoding=utf-8
set hidden
set lazyredraw  " Do not redraw while running macros (much faster)
set infercase   " Case sensitive insert completion even if ingorecase is set
set backup
set backupdir=~/.vim/backup
set directory=~/.vim/backup " Stores swap files there
set writebackup
set ttymouse=xterm2 " Make mouse work on virtual terms like screen
set whichwrap=b,s,<,>
set wildignore+=*.o,*.obj,*.git*,*cache/*,*gen/*
set history=200
set grepprg=git\ grep\ -n\ $*
" }}}

" Visual options {{{
set showmatch
set nohlsearch
set ruler
set visualbell
set wildmenu
set wildmode=list:longest,full
set guicursor+=a:blinkon0
" }}}

" Text formatting options {{{
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab
set backspace=indent,eol,start
set textwidth=0
set autoindent
set ignorecase
set smartcase
" }}}

" Vim UI options {{{
set laststatus=2
set showcmd
set showmode
set cursorline
" }}}

" Color options {{{
" See http://www.vim.org/tips/tip.php?tip_id=1312
" 256 colors may be needed for any other colorscheme exexpt solarized
"set t_Co=256
" Needed for solarized: Use the 16 colors terminal option to get VIM to look
" like GVIM with solarized colors.
set t_Co=16
syntax on
set background=dark
" }}}

" Autocommands {{{
augroup mygroup
    " clear the group's autocommand
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
    autocmd FileType make setlocal noexpandtab
    " See: http://bjori.blogspot.fr/2010/01/unix-manual-pages-for-php-functions.html
    autocmd FileType php setlocal keywordprg=pman
    autocmd BufNewFile,BufRead *.as     set filetype=actionscript
    autocmd BufNewFile,BufRead *.html   set filetype=html.twig
    " Show the signs column even if it is empty, useful for the quickfixsigns plugin
    autocmd BufEnter * sign define dummy
    autocmd BufEnter * execute 'sign place 9999 line=1 name=dummy buffer=' . bufnr('')
augroup END
" }}}

" Mappings {{{
set winaltkeys=no

" Get to know the current pattern count match
nnoremap <leader>o :%s///gn<cr>

" Quick way to recall macro a
nnoremap <leader>2 @a

" Quick way to recall last command
nnoremap <leader>3 @:

" Toggles highlight search
nnoremap <silent> <leader>h :set invhlsearch<cr>

" Edit ~/.vimrc or ~/.zshrc
nnoremap <leader>E :edit $MYVIMRC<cr>
nnoremap <leader>Z :edit ~/.zshrc<cr>

" Source my vimrc
nnoremap <leader>S :source $MYVIMRC<cr>

" Hashrocket shortcut compliments of TextMate
inoremap <c-l> <space>=><space>

" make pack
nnoremap <leader>m :!make pack<cr>

" Toggle paste on or off
nnoremap <leader>sp :call TogglePaste()<cr>

" Toggle mouse on or off
nnoremap <leader><cr> :call ToggleActiveMouse()<cr>

" call the tagbar window
nnoremap tt :TagbarToggle<cr>

" Command-t
nnoremap <leader>ff :CommandT<space>
nnoremap <leader>fb :CommandTBuffer<cr>

" save file whether in insert or normal mode
inoremap <c-s> <c-o>:w<cr><esc>
nnoremap <c-s> :w<cr>

" Switch to the next/previous buffer
noremap <leader><Tab> :bn<cr>
noremap <leader><S-Tab> :bp<cr>

" Switch to the next/previous tab
noremap <leader><leader><Tab> :tabnext<cr>
noremap <leader><leader><S-Tab> :tabprevious<cr>

" Quicker way to delete a buffer
nnoremap <del> :BD<cr>

" run java
nnoremap <leader>r :!ant run<cr>

" The Project plugin
noremap <silent> <leader>p :Project<cr>

" fugitive
nnoremap <leader>Gg :Ggrep<SPACE>
nnoremap <leader>Gd :Gdiff<cr>
" switch back to current file and closes fugitive buffer
nnoremap <leader>GD :diffoff!<cr><C-W>h:bd<cr>

" PDV-revised
nnoremap <C-p> :call PhpDoc()<cr>

" Remap , since it's my <leader>
" Useful to go back to the previous occurence when using the f{char} motion
nnoremap \ ,

" Centers the found search
noremap <leader>n nzz
noremap <leader>N Nzz

" <C-R> explained:
" You can insert the result of a Vim expression in insert mode using the <C-R>=
" command. For example, the following command creates an insert mode map command
" that inserts the current directory:
" :inoremap <F2> <C-R>=expand('%:p:h')<cr>
inoremap <Tab> <C-R>=SuperCleverTab()<cr>
" }}}

" Abbreviations {{{
ab xr print_r($
ab xv var_dump($
ab xe error_log(
ab cl console.log(
ab fu function
" }}}

" Vundle plugins {{{

" vundle
filetype off    " required!
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
Bundle 'gmarik/vundle'

" Repos on github
"Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
"Bundle 'tpope/vim-rails.git'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-abolish'
Bundle 'mattn/zencoding-vim'
Bundle 'inside/snipMate'
Bundle 'inside/actionscript.vim'
Bundle 'inside/fortuneod'
Bundle 'inside/selfinder'
Bundle 'inside/phpcomplete.vim'
Bundle 'inside/vim-grep-operator'
Bundle 'tpope/vim-speeddating'
Bundle 'tpope/vim-repeat'
Bundle 'majutsushi/tagbar'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'wincent/Command-T'
Bundle 'inside/CSScomb-for-Vim'
Bundle 'vim-scripts/vimwiki'
Bundle 'godlygeek/tabular'
Bundle 'altercation/vim-colors-solarized'
Bundle 'beyondwords/vim-twig'
Bundle 'nelstrom/vim-visual-star-search'
Bundle 'Raimondi/delimitMate'
Bundle 'othree/xml.vim'
Bundle 'tomtom/quickfixsigns_vim'

" Github vim-scripts repos
Bundle 'L9'
Bundle 'bufkill.vim'
Bundle 'matchit.zip'
Bundle 'project.tar.gz'
Bundle 'sessionman.vim'
Bundle 'Syntastic'
Bundle 'darkburn'
Bundle 'DBGPavim'
Bundle 'PDV--phpDocumentor-for-Vim'
Bundle 'Smooth-Scroll'
Bundle 'Toggle'
Bundle 'camelcasemotion'

" Non github repos
"Bundle 'git://git.wincent.com/command-t.git'

filetype plugin indent on   " required!

" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..
" }}}

" Plugins configuration {{{
" zencoding
let g:user_zen_leader_key = '<c-k>'

" DBGPavim
let g:dbgPavimPort = 9001
let g:dbgPavimBreakAtEntry = 0

" Syntastic
" Available checkers are: php, phpcs, phpmd.
" Let's stick to the php executable only.
let g:syntastic_php_checkers = ['php']
let g:syntastic_mode_map = {'passive_filetypes': ['html']}

" Command-t
let g:CommandTMaxFiles = 100000

" Fortuneod
let g:fortuneod_botright_split = 0

" Toggle
nnoremap <leader>t :call Toggle()<cr>

" Vimwiki
" Don't use noremap
nmap <leader>W <Plug>VimwikiIndex

" delimitMate
let delimitMate_expand_cr = 1

" quickfixsigns
let g:quickfixsigns_classes = ['qfl', 'loc', 'vcsdiff']

" vim-grep-operator
nmap <leader>g <Plug>GrepOperatorOnCurrentDirectory
vmap <leader>g <Plug>GrepOperatorOnCurrentDirectory
nmap <leader><leader>g <Plug>GrepOperatorWithFilenamePrompt
vmap <leader><leader>g <Plug>GrepOperatorWithFilenamePrompt
" }}}

" Colorscheme {{{
" When solarized is not configured on the terminal,
" my prefered colorscheme is darkburn.
"colorscheme darkburn
colorscheme solarized
" }}}
