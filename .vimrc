inoremap jk <ESC>
" let g:mapleader = "\<Space>"
let g:mapleader = ";"
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>wq :wq<CR>
" 设置快捷键将选中文本块复制至系统剪贴板
vnoremap <Leader>y "+y
" 设置快捷键将系统剪贴板内容粘贴至 vim
nmap <Leader>p "+p
" 依次遍历子窗口
nnoremap ;nw <C-W><C-W>
" 禁止gui光标闪烁
set gcr=a:block-blinkon0

nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap * *zzzv
nnoremap # #zzzv
nnoremap g* g*zzzv
nnoremap g# g#zzzv


map <C-x><C-b> :ls<CR>
map <C-x>b :b<Space>
nmap <Leader>s :shell<CR>
" Edit the .bashrc"
nmap <silent> <leader>eb :e ~/.bashrc<CR>
" Edit the .vimrc"
nmap <silent> <leader>ev :e ~/.vimrc<CR>
" Paste and visual paste improvments {{{
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]
" Useful mappings for managing tabs
map <leader>tn :tabnew<CR>
map <leader>te :tabedit<Space>
map <leader>to :tabonly<CR>
map <leader>tc :tabclose<CR>
map <leader>tm :tabmove<Space>
map <C-h> :tabprevious<CR>
map <C-l> :tabnext<CR>
" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" :W sudo saves the file
" (useful for handling the permission-denied error)
command! W w !sudo tee % > /dev/null

" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

autocmd BufWinLeave *.* silent! mkview " Make Vim save view (state) (folds, cursor, etc)
autocmd BufWinEnter *.* silent! loadview " Make Vim load view (state) (folds, cursor, etc)
" To have Vim jump to the last position when reopening a file
" autocmd BufReadPost * exe "normal! g`\""

" Add a bit extra margin to the left
"set foldcolumn=1
" How many tenths of a second to blink when matching brackets
"set mat=2
" For regular expressions turn very magic on
:nnoremap / /\v
:cnoremap %s/ %s/\v
set virtualedit=block
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7
" Height of the command bar
set cmdheight=1
set colorcolumn=80
set visualbell noerrorbells " don't beep
set guioptions=a            " hide scrollbars/menu/tabs
set ttyfast
" Set to auto read when a file is changed from the outside
set autoread
" 关闭vi的一致性模式 避免以前版本的一些Bug和局限
set nocompatible
" 配置backspace键工作方式
set backspace=indent,eol,start
" 显示行号
set number
nnoremap <F6> :set nonumber!<CR>:set foldcolumn=0<CR>
" 设置在编辑过程中右下角显示光标的行列信息
" Makes search act like search in modern browsers
set incsearch
set ruler
" 当一行文字很长时取消换行
set nowrap
set wrap
" 在状态栏显示正在输入的命令
set showcmd
" 设置历史记录条数
set history=100
" 设置取消备份 禁止临时文件生成
" set nobackup
set noswapfile
" 突出现实当前行列、高亮当前行列
set cursorline
" set cursorcolumn
" 设置匹配模式 类似当输入一个左括号时会匹配相应的那个右括号
set showmatch
" 设置C/C++方式自动对齐
set autoindent
set smartindent
set cindent
" 开启语法高亮功能
syntax enable syntax on
" 指定配色方案为256色
set t_Co=256
" 设置搜索时忽略大小写
set ignorecase
" 设置在Vim中可以使用鼠标 防止在Linux终端下无法拷贝
" In many terminal emulators the mouse works just fine, thus enable it.
set mouse=a
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
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set title
set titlestring=%t%(\ %m%)%(\ (%{expand('%:p:h')})%)%(\ %a%)
set showtabline=2 " Always show tab line"
" Set up tab labels
set guitablabel=%m%N:%t[%{tabpagewinnr(v:lnum)}]
set tabline=%!MyTabLine()
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
set shortmess=at
" Set up tab tooltips with each buffer name
set guitabtooltip=%F
if has("gui_running")
    set guioptions-=m "Remove menubar"
    set guioptions-=T "Remove toolbar"
    set guioptions-=r "Remove v_scroll bar"
    set mousemodel=extend
    set guifont=Consolas
    language messages en_US.utf-8
endif
" 检测文件类型
filetype on
" 针对不同的文件采用不同的缩进方式
filetype indent on
" 允许插件
filetype plugin on
" 启动智能补全
filetype plugin indent on

"NeoBundle Scripts-----------------------------
if has('vim_starting')
if &compatible
set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/home/x/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('/home/x/.vim/bundle'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" Add or remove your Bundles here:
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'flazz/vim-colorschemes'

" You can specify revision/branch/tag.
NeoBundle 'Shougo/vimshell', { 'rev' : '3787e5' }

" === The-NERD-tree 目录导航插件 ===
NeoBundle 'scrooloose/nerdtree'
" 开启目录导航快捷键映射成<Leader>t
nnoremap <Leader>t :NERDTreeToggle<CR>
" 高亮鼠标所在的当前行
" let NERDTreeHighlightCursorline=1
NeoBundle 'bling/vim-airline'
set laststatus=2
" === A 头文件和实现文件自动切换插件 ===
NeoBundle 'vim-scripts/a.vim'
"=== ctrlp 文件搜索插件 不需要外部依赖包 ===
NeoBundle 'kien/ctrlp.vim'
" 设置开始文件搜索的快捷键
let g:ctrlp_map = '<leader>p'
" 设置默认忽略搜索的文件格式
let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$\|.rvm$'
" 设置搜索时显示的搜索结果最大条数
let g:ctrlp_max_height=15
" === YouCompleteMe 自动补全插件===
NeoBundle 'Valloric/YouCompleteMe', {
                \ 'build' : {
                \     'mac' : './install.sh --clang-completer --system-libclang --omnisharp-completer',
                \     'unix' : './install.sh --clang-completer --system-libclang --omnisharp-completer',
                \     'windows' : './install.sh --clang-completer --system-libclang --omnisharp-completer',
                \     'cygwin' : './install.sh --clang-completer --system-libclang --omnisharp-completer'
                \    }
                \ }
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
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


NeoBundle 'SirVer/ultisnips'
NeoBundle 'honza/vim-snippets'
let g:UltiSnipsExpandTrigger="<c-l>"
let g:UltiSnipsJumpForwardTrigger="<c-n>"
let g:UltiSnipsJumpBackwardTrigger="<c-p>"
" === 自动补全单引号、双引号、括号等 ===
NeoBundle 'Raimondi/delimitMate'
" === 主题solarized ===
NeoBundle 'altercation/vim-colors-solarized'
" let g:solarized_termtrans=1
let g:solarized_contrast="normal"
let g:solarized_visibility="normal"
" === 主题 molokai ===
NeoBundle 'tomasr/molokai'
set background=dark
set t_Co=256
" === indentLine代码排版缩进标识 ===
NeoBundle 'Yggdroot/indentLine'
let g:indentLine_noConcealCursor = 1
let g:indentLine_color_term = 0
" 缩进的显示标识|
let g:indentLine_char = '¦'
" === vim-trailing-whitespace将代码行最后无效的空格标红 ===
NeoBundle 'bronson/vim-trailing-whitespace'
" === markdown编辑插件 ===
NeoBundle 'plasticboy/vim-markdown'
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
let g:vim_markdown_folding_disabled=1
" === golang编辑插件 ===
NeoBundle 'jnwhiteh/vim-golang'
" 自动检测文件编码
NeoBundle 'FencView.vim'

NeoBundle 'mattn/emmet-vim'
NeoBundle 'othree/html5.vim'
NeoBundle 'pangloss/vim-javascript'
" NeoBundle 'xuhdev/SingleCompile'
NeoBundle 'tpope/vim-dispatch'
NeoBundle 'TagHighlight'
NeoBundle 'klen/python-mode'
NeoBundle 'easymotion/vim-easymotion'
let g:EasyMotion_leader_key = '<Space>'
NeoBundle 'taglist.vim'
NeoBundle 'terryma/vim-multiple-cursors'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'godlygeek/tabular'
NeoBundle 'wookiehangover/jshint.vim'
NeoBundle 'tomtom/tcomment_vim'
nnoremap <C-k> :TComment<CR>
NeoBundle 'bling/vim-bufferline'
NeoBundle 'mhinz/vim-startify'
let g:startify_list_order = ['files', 'dir', 'bookmarks', 'sessions']
let g:startify_bookmarks = [ '~/.vimrc' ]
NeoBundle 'junegunn/goyo.vim'
NeoBundle 'AndrewRadev/splitjoin.vim'
NeoBundle 'tpope/vim-unimpaired'
NeoBundle 'unblevable/quick-scope'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'xuhdev/SingleCompile'
NeoBundle 'Shougo/vimproc', {
                \ 'build' : {
                \     'windows' : 'make -f make_mingw32.mak',
                \     'cygwin' : 'make -f make_cygwin.mak',
                \     'mac' : 'make -f make_mac.mak',
                \     'unix' : 'make -f make_unix.mak',
                \    },
                \ }


" syntastic
" ==========================
NeoBundle 'scrooloose/syntastic'
let g:syntastic_check_on_open = 1
let g:syntastic_cpp_include_dirs = ['/usr/include/']
let g:syntastic_cpp_remove_include_errors = 1
let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = '-std=c++11 -stdlib=libstdc++'
"set error or warning signs
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
"whether to show balloons
let g:syntastic_enable_balloons = 1

" Required:
call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

colorscheme molokai
" Let h/l can move across line
set whichwrap+=<,>,h,l
cnoremap <c-b> <Left>
cnoremap <c-f> <Right>
noremap <c-a> <Home>
noremap <c-e> <End>
inoremap <c-d> <Del>
inoremap <c-h> <BS>
set noshowcmd
vnoremap <Space><Space> zf
nnoremap <silent> <Space><Space> @=(foldlevel('.') ? 'za' : '\<Space>')<CR>
