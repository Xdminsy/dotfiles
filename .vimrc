set nu
set ruler
inoremap jk <ESC>
" let g:mapleader = "\<Space>"
let g:mapleader = ";"
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>wq :wq<CR>
" http://www.tuicool.com/articles/f6feae
" 设置快捷键将选中文本块复制至系统剪贴板
vnoremap <Leader>y "+y
" 设置快捷键将系统剪贴板内容粘贴至 vim
nmap <Leader>p "+p
" 依次遍历子窗口
nnoremap nw <C-W><C-W>
" 禁止gui光标闪烁
set gcr=a:block-blinkon0

" Uncomment the following to have Vim jump to the last position when reopening a file
if has("autocmd")
    au BufReadPost * exe "normal! g`\""
endif

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 
map <leader>t<leader> :tabnext 
" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" gvim on windows
if has("win32")
set guioptions-=m "Remove menubar"
set guioptions-=T "Remove toolbar"
set guioptions-=r "Remove v_scroll bar"
set mousemodel=extend
set guifont=Consolas
language messages en_US.utf-8
endif


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

" Add a bit extra margin to the left
"set foldcolumn=1
" How many tenths of a second to blink when matching brackets
"set mat=2
" For regular expressions turn very magic on
:nnoremap / /\v
:cnoremap %s/ %s/\v
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7
" Height of the command bar
"set cmdheight=2
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
if has('mouse')
    set mouse=a
endif
" 设置Tab宽度
set tabstop=4
" 设置自动对齐空格数
set shiftwidth=4
" 设置按退格键时可以一次删除4个空格
set softtabstop=4
" 设置按退格键时可以一次删除4个空格
set smarttab
" 将Tab键自动转换成空格 真正需要Tab键时使用[Ctrl + V + Tab]
set expandtab
" 设置编码方式
set encoding=utf-8
" 自动判断编码时 依次尝试一下编码
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
" 检测文件类型
filetype on
" 针对不同的文件采用不同的缩进方式
filetype indent on
" 允许插件
filetype plugin on
" 启动智能补全
filetype plugin indent on

" Vundle start
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()
" === 使用Vundle来管理Vundle ===
Plugin 'gmarik/Vundle.vim'
" === The-NERD-tree 目录导航插件 ===
Plugin 'scrooloose/nerdtree'
" 开启目录导航快捷键映射成n键
nnoremap <c-t> :NERDTreeToggle<CR>
" 高亮鼠标所在的当前行
" let NERDTreeHighlightCursorline=1
Plugin 'bling/vim-airline'
" === AirLine插件 状态栏增强展示 ===
" vim有一个状态栏 加上airline则有两个状态栏
set laststatus=2
" === A 头文件和实现文件自动切换插件 ===
Plugin 'vim-scripts/a.vim'
"=== ctrlp 文件搜索插件 不需要外部依赖包 ===
Plugin 'kien/ctrlp.vim'
" 设置开始文件搜索的快捷键
let g:ctrlp_map = '<leader>p'
" 设置默认忽略搜索的文件格式
let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$\|.rvm$'
" 设置搜索时显示的搜索结果最大条数
let g:ctrlp_max_height=15
" === YouCompleteMe 自动补全插件===
Plugin 'Valloric/YouCompleteMe'
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


Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
let g:UltiSnipsExpandTrigger="<c-l>"
let g:UltiSnipsJumpForwardTrigger="<c-n>"
let g:UltiSnipsJumpBackwardTrigger="<c-p>"
" === 自动补全单引号、双引号、括号等 ===
Plugin 'Raimondi/delimitMate'
" === 主题solarized ===
Plugin 'altercation/vim-colors-solarized'
" let g:solarized_termtrans=1
let g:solarized_contrast="normal"
let g:solarized_visibility="normal"
" === 主题 molokai ===
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
let g:vim_markdown_folding_disabled=1
" === golang编辑插件 ===
Plugin 'jnwhiteh/vim-golang'
" 自动检测文件编码
Plugin 'FencView.vim'

Plugin 'mattn/emmet-vim'
Plugin 'othree/html5.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'xuhdev/SingleCompile'
Plugin 'TagHighlight'
Plugin 'klen/python-mode'
Plugin 'easymotion/vim-easymotion'
let g:EasyMotion_leader_key = 'f'
Plugin 'taglist.vim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'scrooloose/nerdcommenter'
Plugin 'godlygeek/tabular'

" syntastic
" ==========================
Plugin 'scrooloose/syntastic'
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
" ==========================
" ==========================
call vundle#end()
filetype plugin indent on
" Vundle end

colorscheme molokai
" Let h/l can move across line
set whichwrap+=<,>,h,l
cnoremap <c-b> <Left>
cnoremap <c-f> <Right>
noremap <c-a> <Home>
noremap <c-e> <End>
inoremap <c-d> <Del>
inoremap <c-h> <BS>
noremap <c-b> :SingleCompile<CR>:SingleCompileRun<CR>

