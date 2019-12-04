" Maps {{{
inoremap jk <ESC>
" let g:mapleader = "\<Space>"
let g:mapleader = ";"
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :conf q<CR>
nnoremap <Leader>wq :wq<CR>
" 设置快捷键将选中文本块复制至系统剪贴板
vnoremap <Leader>y "+y
" 设置快捷键将系统剪贴板内容粘贴至 vim
nmap <Leader>p "+p
" 依次遍历子窗口
nnoremap ;nw <C-W><C-W>
nnoremap <F6> :set nonumber!<CR>:set foldcolumn=0<CR>

" Add a bit extra margin to the left
"set foldcolumn=1
" How many tenths of a second to blink when matching brackets
"set mat=2
" For regular expressions turn very magic on
:nnoremap / /\v
:cnoremap %s/ %s/\v

" Select last inserted text
nnoremap gV `[v`]
" move to beginning/end of line
nnoremap B ^
nnoremap E $
" move vertically by visual line
nnoremap j gj
nnoremap k gk
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap * *zzzv
nnoremap # #zzzv
nnoremap g* g*zzzv
nnoremap g# g#zzzv
" map <F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

noremap <leader>bg :call ToggleBG()<CR>
nnoremap <Leader>s :shell<CR>
" Edit the .bashrc"
nnoremap <silent> <leader>eb :e ~/.bashrc<CR>
" Edit the .vimrc"
nnoremap <silent> <leader>ev :tabedit $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]
" Useful mappings for managing tabs
noremap <leader>tn :tabnew<CR>
noremap <leader>te :tabedit<Space>
noremap <leader>to :tabonly<CR>
noremap <leader>tc :tabclose<CR>
noremap <leader>tm :tabmove<Space>
noremap <leader>th :tabprevious<CR>
noremap <leader>tl :tabnext<CR>
" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
noremap <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" :W sudo saves the file
" (useful for handling the permission-denied error)
command! W w !sudo tee % > /dev/null

" Pressing ,ss will toggle and untoggle spell checking
noremap <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
noremap <leader>sn ]s
noremap <leader>sp [s
noremap <leader>sa zg
noremap <leader>s? z=

noremap 0 ^
" Emacs hotkeys {{{
map! <c-b> <Left>
map! <c-f> <Right>
map! <c-a> <Home>
map! <c-e> <End>
" cnoremap <c-d> <Del>
inoremap <c-d> <Del>
" map! <c-h> <BS>
inoremap <c-s> <c-o>:update<CR>
noremap <c-z> u
inoremap <c-z> <c-o>u
" noremap <c-y> <c-r>
" inoremap <c-y> <c-o><c-r>
vnoremap <c-c> "+y
nnoremap <c-p> "+p
" vnoremap <c-insert> "+y
" }}}
" }}}
" Functions {{{
function! ToggleBG()
    let s:tbg = &background
    if s:tbg == "dark"
        set background=light
    else
        set background=dark
    endif
endfunction

function! MyTabLine()
    let s=''
    let t=tabpagenr() " The index of current page
    let i=1
    while i<=tabpagenr('$') " From the first page
        let buflist=tabpagebuflist(i)
        let winnr=tabpagewinnr(i)
        let s.=(i==t ? '%#TabLineSel#' : '%#TabLine#')
        let s.='%'.i.'T'
        let s.=' '
        let bufnr=buflist[winnr-1]
        let file=bufname(bufnr)
        let buftype = getbufvar(bufnr, 'buftype')
        let m=''
        if getbufvar(bufnr, '&modified')
            let m='[+]'
        endif
        if buftype=='nofile'
            if file=~'\/.'
                let file=substitute(file, '.*\/\ze.', '', '')
            endif
        else
            let file=fnamemodify(file, ':p:t')
        endif
        if file==''
            let file='[No Name]'
        endif
        let s.=m
        let s.=i.':'
        let s.=file
        let s.='['.winnr.']'
        let s.=' '
        let i=i+1
    endwhile
    let s.='%T%#TabLineFill#%='
    let s.=(tabpagenr('$')>1 ? '%999XX' : 'X')
    return s
endfunction

" Thanks to David Ljung Madison
" # Function to permanently delete views created by 'mkview'
function! MyDeleteView()
    let path = fnamemodify(bufname('%'),':p')
    " vim's odd =~ escaping for /
    let path = substitute(path, '=', '==', 'g')
    if empty($HOME)
    else
        let path = substitute(path, '^'.$HOME, '\~', '')
    endif
    let path = substitute(path, '/', '=+', 'g') . '='
    " view directory
    let path = &viewdir.'/'.path
    call delete(path)
    echo "Deleted: ".path
endfunction
" # Command Delview (and it's abbreviation 'delview')
command! Delview call MyDeleteView()
" Lower-case user commands: http://vim.wikia.com/wiki/Replace_a_builtin_command_using_cabbrev
cabbrev delview <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'Delview' : 'delview')<CR>

" }}}
" Autocmds {{{
augroup mine
    autocmd BufWinLeave *.* silent! mkview " Make Vim save view (state) (folds, cursor, etc)
    autocmd BufWinEnter *.* silent! loadview " Make Vim load view (state) (folds, cursor, etc)
    " To have Vim jump to the last position when reopening a file
    " autocmd BufReadPost * exe "normal! g`\""
augroup END
" }}}
" Sets {{{
set nocompatible
set shortmess=atI
set virtualedit=block
set whichwrap+=<,>,h,l
set scrolloff=4
set cmdheight=1
set colorcolumn=80
set novisualbell noerrorbells " don't beep
set ttyfast
set autoread
set backspace=indent,eol,start
set number
set incsearch
set hlsearch
set ruler
set nowrap
set showcmd
set history=100
set nobackup
set writebackup
set noswapfile
set cursorline
set nocursorcolumn
set showmatch
set autoindent
set smartindent
set modeline
set modelines=5
set cindent
syntax enable syntax on
set t_Co=256
set ignorecase
set smartcase
" set mouse=a " Enable mouse for all previous mode
set wildmenu            " visual autocomplete for command menu"
set mousehide
" 禁止gui光标闪烁
set gcr=a:block-blinkon0
" 设置Tab宽度
set tabstop=4
set expandtab
" 设置自动对齐空格数
set shiftwidth=4
" 设置按退格键时可以一次删除4个空格
set softtabstop=4
set shiftround
" 设置按退格键时可以一次删除4个空格
set smarttab
" 将Tab键自动转换成空格 真正需要Tab键时使用[Ctrl + V + Tab]
set showcmd         " Show (partial) command in status line.
set expandtab
" 设置编码方式
set encoding=utf-8
" 自动判断编码时 依次尝试一下编码
set noshowcmd
vnoremap <Space><Space> zf
nnoremap <silent> <Space><Space> @=(foldlevel('.') ? 'za' : '\<Space>')<CR>
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set title
set foldlevelstart=10   " open most folds by default"
set foldmethod=indent   " fold based on indent level"
set foldnestmax=10      " 10 nested fold max"
set lazyredraw          " redraw only when we need to."
set titlestring=%t%(\ %m%)%(\ (%{expand('%:p:h')})%)%(\ %a%)
set showtabline=2 " Always show tab line"
" Set up tab labels
set guitablabel=%m%N:%t[%{tabpagewinnr(v:lnum)}]
set tabline=%!MyTabLine()
set shortmess=at
" Set up tab tooltips with each buffer name
set guitabtooltip=%F
set pastetoggle=<F12>
set belloff=all " Disable all annoying bells
set t_ut= " Prevent wrong background color
filetype plugin indent on
" }}}
" Plugin Scripts {{{
" Neobundle Start {{{
if has('vim_starting')
if &compatible
set nocompatible               " Be iMproved
endif

" Required:

" set runtimepath+=~/.vim/bundle/neobundle.vim/

endif

" Required:
" call neobundle#begin(expand('~/.vim/bundle'))

" Let NeoBundle manage NeoBundle
" Required:
" NeoBundleFetch 'Shougo/neobundle.vim'
" }}}
" Vundle Start {{{
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" }}}

Plugin 'matchit.zip'
Plugin 'neoclide/coc.nvim'
Plugin 'tpope/vim-surround'
Plugin 'Shougo/neosnippet.vim'
Plugin 'Shougo/neosnippet-snippets'
Plugin 'tpope/vim-fugitive'
Plugin 'thinca/vim-quickrun'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'flazz/vim-colorschemes'
Plugin 'Shougo/unite.vim'
Plugin 'sickill/vim-pasta'
Plugin 'jremmen/vim-ripgrep'
Plugin 'junegunn/fzf'
Plugin 'shougo/deol.nvim'
Plugin 'ryanoasis/vim-devicons'

Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'Xuyuanp/nerdtree-git-plugin'
let g:nerdtree_tabs_open_on_gui_startup=2
nnoremap <Leader>n :NERDTreeToggle<CR>
Plugin 'bling/vim-airline'
let g:airline_theme='dark'
set laststatus=2
" === A 头文件和实现文件自动切换插件 ===
Plugin 'vim-scripts/a.vim'
" 设置开始文件搜索的快捷键
let g:ctrlp_map = '<leader>p'
" 设置默认忽略搜索的文件格式
let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$\|.rvm$'
" 设置搜索时显示的搜索结果最大条数
let g:ctrlp_max_height=15
" Plugin 'Valloric/YouCompleteMe'
" Plugin 'Valloric/YouCompleteMe', {
"                \ 'build' : {
"                \     'mac' : './install.py --clang-completer --system-libclang --omnisharp-completer',
"                \     'unix' : './install.py --clang-completer --system-libclang --omnisharp-completer',
"                \     'windows' : './install.py --clang-completer --system-libclang --omnisharp-completer',
"                \     'cygwin' : './install.py --clang-completer --system-libclang --omnisharp-completer'
"                \    }
"                \ }
let g:ycm_global_ycm_extra_conf = '~/dotfiles/.ycm_extra_conf.py'
let g:EclimCompletionMethod = 'omnifunc'
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_confirm_extra_conf = 0
let g:ycm_min_num_of_chars_for_completion = 1
" youcompleteme 默认tab s-tab 和自动补全冲突
" let g:ycm_key_list_select_completion=['<c-n>']
" let g:ycm_key_list_select_completion = ['<Down>']
" let g:ycm_key_list_previous_completion=['<c-p>']
" let g:ycm_key_list_previous_completion = ['<Up>']
" nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>
" let g:UltiSnipsExpandTrigger="<c-j>"
"  当选择了一项后自动关闭自动补全提示窗口
" let g:ycm_autoclose_preview_window_after_completion=1


" Plugin 'SirVer/ultisnips'
" Plugin 'honza/vim-snippets'
let g:UltiSnipsExpandTrigger="<c-l>"
let g:UltiSnipsJumpForwardTrigger="<c-n>"
let g:UltiSnipsJumpBackwardTrigger="<c-p>"
let g:UltiSnipsSnippetDirectories=["UltiSnips", "snippets"]
" === 自动补全单引号、双引号、括号等 ===
Plugin 'Raimondi/delimitMate'
Plugin 'altercation/vim-colors-solarized'
" let g:solarized_termtrans=1
let g:solarized_contrast="normal"
let g:solarized_visibility="normal"
Plugin 'tomasr/molokai'
set background=dark
set t_Co=256
" === indentLine代码排版缩进标识 ===
Plugin 'Yggdroot/indentLine'
let g:indentLine_noConcealCursor = 1
let g:indentLine_color_term = 0
" 缩进的显示标识|
let g:indentLine_char = '¦'
" === vim-trailing-whitespace将代码行最后无效的空格标红 ===
Plugin 'bronson/vim-trailing-whitespace'
" === markdown编辑插件 ===
Plugin 'plasticboy/vim-markdown'
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
let g:vim_markdown_folding_disabled=1
" === golang编辑插件 ===
Plugin 'jnwhiteh/vim-golang'
Plugin 'mbbill/fencview'
Plugin 'idris-hackers/idris-vim'
Plugin 'wavded/vim-stylus'
Plugin 'elixir-lang/vim-elixir'
Plugin 'wting/rust.vim'
Plugin 'VimClojure'
" Plugin 'nono/jquery.vim'
Plugin 'moll/vim-node'
Plugin 'shawncplus/phpcomplete.vim'
Plugin 'StanAngeloff/php.vim'
Plugin 'JulesWang/css.vim'
Plugin 'derekwyatt/vim-scala'
Plugin 'mattn/emmet-vim'
Plugin 'othree/html5.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'tpope/vim-dispatch'
Plugin 'TagHighlight'
Plugin 'klen/python-mode'
" let g:pymode_python = 'python3'
Plugin 'easymotion/vim-easymotion'
let g:EasyMotion_leader_key = '<Space>'
" Plugin 'taglist.vim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'scrooloose/nerdcommenter'
Plugin 'godlygeek/tabular'
Plugin 'tomtom/tcomment_vim'
nnoremap <C-k> :TComment<CR>
Plugin 'bling/vim-bufferline'
Plugin 'mhinz/vim-startify'
let g:startify_list_order = ['files', 'dir', 'bookmarks', 'sessions']
let g:startify_bookmarks = [ '~/.vimrc' ]
Plugin 'junegunn/goyo.vim'
Plugin 'AndrewRadev/splitjoin.vim'
Plugin 'tpope/vim-unimpaired'
Plugin 'unblevable/quick-scope'
Plugin 'majutsushi/tagbar'
Plugin 'xuhdev/SingleCompile'
Plugin 'Shougo/vimproc', {
                \ 'build' : {
                \     'windows' : 'make -f make_mingw32.mak',
                \     'cygwin' : 'make -f make_cygwin.mak',
                \     'mac' : 'make -f make_mac.mak',
                \     'unix' : 'make -f make_unix.mak',
                \    },
                \ }
Plugin 'mattn/calendar-vim'
Plugin 'leshill/vim-json'
Plugin 'eagletmt/neco-ghc'
Plugin 'zah/nim.vim'
Plugin 'metakirby5/codi.vim'
" Plugin 'ervandew/supertab'
" Plugin 'AutoComplPop'

" syntastic
" ==========================
Plugin 'scrooloose/syntastic'
let g:syntastic_check_on_open = 1
let g:syntastic_cpp_include_dirs = ['/usr/include/']
let g:syntastic_cpp_remove_include_errors = 1
let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_checkers = ['clang++']
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = ' -std=c++14 -stdlib=libstdc++'
"set error or warning signs
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
"whether to show balloons
let g:syntastic_enable_balloons = 1


" NeoBundle End {{{
" Required:
"call neobundle#end()

" Required:
"filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
"NeoBundleCheck
" }}}
" Vundle End {{{
call vundle#end()
filetype plugin indent on
" }}}

" }}}
" Gvim {{{
if has('gui_running')
    " set guioptions-=m "Remove menubar"
    " set guioptions-=T "Remove toolbar"
    " set guioptions-=r "Remove v_scroll bar"
    " set guioptions=c
    " set mousemodel=extend
    language messages en_US.utf-8
    set guifont=Sarasa_Mono_CL:h10:cANSI:qDRAFT
    set lines=29 columns=140
endif
if has('nvim')
    set guifont=Sarasa\ Mono\ CL:h10:cANSI:qDRAFT
endif
" }}}
" Other vimrc {{{
" Use fork vimrc if available {
if filereadable(expand("~/.vimrc.fork"))
    source ~/.vimrc.fork
endif
" }

" Use local vimrc if available {
if filereadable(expand("~/.vimrc.local"))
    source ~/.vimrc.local
endif
" }

" Use local gvimrc if available and gui is running {
if has('gui_running')
    if filereadable(expand("~/.gvimrc.local"))
        source ~/.gvimrc.local
    endif
endif
" }
" }}}
" End {{{
silent! colorscheme molokai
highlight Visual term=reverse cterm=reverse guibg=Grey
highlight Normal ctermbg=NONE " Use Windows Terminal's animated background image.
highlight Folded ctermbg=NONE " Use Windows Terminal's animated background image.
highlight TabLineFill cterm=NONE
lang en_US
" vim:foldmethod=marker:foldlevel=0
" }}}
