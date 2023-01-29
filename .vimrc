" setting

" 文字コードをUFT-8に設定
set fenc=utf-8
" バックアップファイルを作らない
set nobackup
" スワップファイルを作らない
set noswapfile
" 編集中のファイルが変更されたら自動で読み直す
set autoread
" バッファが編集中でもその他のファイルを開けるように
set hidden
" 入力中のコマンドをステータスに表示する
set showcmd
" コマンドラインモードで<Tab>キーによるファイル名補完を有効にする
set wildmenu
" ファイル名表示
set statusline=%F
" 変更チェック表示
set statusline+=%m
" これ以降は右寄せ表示
set statusline+=%=
" 現在行数/全行数
set statusline+=[%l/%L]
" file encoding
" set statusline+=[%{&fileencoding}]
" ヤンクをクリップボードに保持
set clipboard+=unnamed
" 保存時に行末の空白を削除
autocmd BufWritePre * :%s/\s\+$//ge

" 移動系

" インサートモードのjjをESCとみなす
inoremap jj <Esc>
" 行末の1文字先までカーソルを移動できるように
set virtualedit=onemore
" 折り返し時に表示行単位での移動できるようにする
nnoremap j gj
nnoremap k gk
" 行を跨いでカーソル移動できるように
set whichwrap=b,s,h,l,<,>,[,],~
" スクロール幅に余裕をもたせる
set scrolloff=3
" マウス操作を有効化
set mouse=a

" 見た目系

" 行番号を表示
set number
" 現在の行を強調表示
" set cursorline
" 現在の行を強調表示（縦）
" set cursorcolumn
" 改行時に前の行のインデントを継続する
set autoindent
" 改行時に入力された行の末尾に合わせて次の行のインデントを増減する
set smartindent
" ビープ音を可視化
set visualbell
" 括弧入力時の対応する括弧を表示
set showmatch
" ステータスラインを常に表示
set laststatus=2
" コマンドラインの補完
set wildmode=list:longest
" シンタックスハイライトの有効化
syntax enable
" カラースキームの設定
colorscheme lucius
" モードに応じてカーソル表示を変える
if has('vim_starting')
  " 挿入モード時点滅bar
  let &t_SI .= "\e[5 q"
  " 置換モード時に点滅block
  let &t_SR .= "\e[1 q"
  " ノーマルモード時点滅underscore
  let &t_EI .= "\e[3 q"
endif

" Tab系

" 不可視文字を可視化(タブが「▸-」と表示される)
set list listchars=tab:\▸\-
" Tab文字を半角スペースにする
set expandtab
" 行頭以外のTab文字の表示幅（スペースいくつ分）
set tabstop=2
" 行頭でのTab文字の表示幅
set shiftwidth=2


" 検索系

" 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
" 検索文字列入力時に順次対象文字列にヒットさせる
set incsearch
" 検索時に最後まで行ったら最初に戻る
set wrapscan
" 検索語をハイライト表示
set hlsearch
" ESC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>
