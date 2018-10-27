set number
set cursorline
set cursorcolumn
set laststatus=2
"set cmdheight=2
set showmatch
"set helpheight=999
set list
" 不可視文字の表示記号指定
set listchars=tab:?\ ,eol:?,extends:?,precedes:?

colorscheme molokai
syntax on
let g:molokai_original = 1
let g:rehash256 = 1
set background=dark


" カーソル移動関連の設定
set backspace=indent,eol,start
set whichwrap=b,s,h,l,<,>,[,]
"set scrolloff=8
"set sidescrolloff=16
"set sidescroll=1

" ファイル処理関連の設定
set confirm
set hidden
set autoread
set nobackup
set noswapfile

" 検索/置換の設定

set hlsearch
set incsearch
set ignorecase
set smartcase
set wrapscan

" タブ/インデントの設定

set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
"set smartindent

" 動作環境との統合関連の設定
set clipboard=unnamed,unnamedplus
set mouse=a
set shellslash
"set iminsert=2

" コマンドラインの設定
"set wildmenu wildmode=list:longest,full
set history=10000

" ビープの設定
set visualbell t_vb=
set noerrorbells

""""""""""""""""""""""""""""""
" プラグインのセットアップ
""""""""""""""""""""""""""""""
if has('vim_starting')
  set nocompatible               " Be iMproved

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" ファイルオープンを便利に
NeoBundle 'Shougo/unite.vim'
" Unite.vimで最近使ったファイルを表示できるようにする
NeoBundle 'Shougo/neomru.vim'

""""""""""""""""""""""""""""""
" Unit.vimの設定
""""""""""""""""""""""""""""""
" 入力モードで開始する
let g:unite_enable_start_insert=1
" バッファ一覧
noremap  :Unite buffer
" ファイル一覧
noremap  :Unite -buffer-name=file file
" 最近使ったファイルの一覧
noremap  :Unite file_mru
" sourcesを「今開いているファイルのディレクトリ」とする
noremap :uff :UniteWithBufferDir file -buffer-name=file
" ウィンドウを分割して開く
au FileType unite nnoremap     unite#do_action('split')
au FileType unite inoremap     unite#do_action('split')
" ウィンドウを縦に分割して開く
au FileType unite nnoremap     unite#do_action('vsplit')
au FileType unite inoremap     unite#do_action('vsplit')
" ESCキーを2回押すと終了する
au FileType unite nnoremap    :q
au FileType unite inoremap    :q
""""""""""""""""""""""""""""""

" ファイルをtree表示してくれる
NeoBundle 'scrooloose/nerdtree'
" コメントON/OFFを手軽に実行
NeoBundle 'tomtom/tcomment_vim'
" シングルクオートとダブルクオートの入れ替え等
NeoBundle 'tpope/vim-surround'
" インデントに色を付けて見やすくする
NeoBundle 'nathanaelkane/vim-indent-guides'
" vimを立ち上げたときに、自動的にvim-indent-guidesをオンにする
let g:indent_guides_enable_on_vim_startup = 1
" ログファイルを色づけしてくれる
NeoBundle 'vim-scripts/AnsiEsc.vim'
" 行末の半角スペースを可視化
NeoBundle 'bronson/vim-trailing-whitespace'

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""
" 全角スペースの表示
""""""""""""""""""""""""""""""
function! ZenkakuSpace()
    highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
endfunction

if has('syntax')
    augroup ZenkakuSpace
        autocmd!
        autocmd ColorScheme * call ZenkakuSpace()
        autocmd VimEnter,WinEnter,BufRead * let w:m1=matchadd('ZenkakuSpace', '　')
    augroup END
    call ZenkakuSpace()
endif
""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""
" 挿入モード時、ステータスラインの色を変更
""""""""""""""""""""""""""""""
let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=blue ctermbg=yellow cterm=none'

if has('syntax')
  augroup InsertHook
    autocmd!
    autocmd InsertEnter * call s:StatusLine('Enter')
    autocmd InsertLeave * call s:StatusLine('Leave')
  augroup END
endif

let s:slhlcmd = ''
function! s:StatusLine(mode)
  if a:mode == 'Enter'
    silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
    silent exec g:hi_insert
  else
    highlight clear StatusLine
    silent exec s:slhlcmd
  endif
endfunction

function! s:GetHighlight(hi)
  redir => hl
  exec 'highlight '.a:hi
  redir END
  let hl = substitute(hl, '[\r\n]', '', 'g')
  let hl = substitute(hl, 'xxx', '', '')
  return hl
endfunction
""""""""""""""""""""""""""""""
