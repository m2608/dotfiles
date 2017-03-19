" внешний вид {{{
" цветовая схема
colorscheme zenburn
" подсветка синтаксиса
syntax on
" выравнивание кода 
filetype plugin indent on
" в последних строках файла можно указывать настройки vim для данного файла
set modeline
" показывать номера строк
set number
" подсвечивать строку с курсором
set cursorline
" показывать парные скобки
set showmatch
" Настройка радужных скобок
autocmd Syntax clojure RainbowParenthesesLoadRound
autocmd Syntax clojure RainbowParenthesesLoadSquare
"autocmd VimEnter RainbowParenthesesToggle
"autocmd BufEnter *.clj RainbowParenthesesToggle
"autocmd BufLeave *.clj RainbowParenthesesToggle
nmap <Leader>( :RainbowParenthesesToggle<CR>
" размер табуляции - 4 пробела
set tabstop=4
" заменять табуляции пробелами для всех файлов, кроме Makefile
set expandtab
autocmd FileType make setlocal noexpandtab
" количество пробелов для автовыравнивания кода
set shiftwidth=4
" меню для автодополнения
set wildmenu
" всегда показывать строку статуса
set laststatus=2
" показываем кодировку в строке статуса
if has("statusline")
    set statusline=%<%f\ %h%m%r%=%{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\ \"}%k\ %-14.(%l,%c%V%)\ %P
endif
" настройка курсора
if &term =~ "xterm" || &term =~ "screen"
    " blinking vertical bar
    let &t_SI .= "\<Esc>[5 q"
    " blinking block
    let &t_EI .= "\<Esc>[1 q"
endif
" }}}
" поиск {{{
" показывать найденное в процессе набора строки для поиска
set incsearch 
" если в строке для поиска нет больших букв - игнорировать регистр
set smartcase 
" подсвечивать найденное
set hlsearch
" забой убирает подсветку найденных фраз
nmap <silent> <BS>  :nohlsearch<CR>
" }}}
" сворачивание кода {{{
" включить сворачивание
set foldenable
" по умолчанию открывать 5 уровней свертки
set foldlevelstart=5
" максимальный уровень вложенных сверток
set foldnestmax=5
" используем пробел для сворачивания/разворачивания текущего блока
nnoremap <space> za
" сворачиваем код по умолчанию на основе синтаксиса
set foldmethod=syntax
" }}}
" поведение {{{
" обновлять свап-файл каждые 10 строк (а не 200, как по умолчанию)
set updatecount=10
" текущий каталог будет автоматически меняться при открытии файла, смене буффера и т.п.
set autochdir
" устанавливаем программу, вызываемую при выполнении команды make (нужно во FreeBSD)
set makeprg=gmake
" }}}
" локализация {{{
" добавить русскую раскладку (переключение по ctrl+^)
set keymap=russian-jcukenwin
" использовать ее по умолчанию при запуске vim
set iminsert=0
set imsearch=0
" бирюзовый курсор при включенной русской раскладке
highlight lCursor guifg=NONE guibg=Cyan cterm=none ctermfg=none ctermbg=214
" }}}
" шифрование {{{
" устанавливаем метод шифрования по умолчанию
set cryptmethod=blowfish2
" }}}
" настройка pathogen {{{
" запускаем pathogen, более удобный способ устанавливать плагины (каждый в отдельном каталоге)
execute pathogen#infect()
" автоматически перегружаем конфиг при его сохранении
nmap <silent> ;v :next $MYVIMRC<CR>
augroup VimReload
    autocmd!
    autocmd BufWritePost  $MYVIMRC  source $MYVIMRC
augroup END
" }}}
" настройка slime {{{
" используем tmux для vim-slime
let g:slime_target = "tmux"
let g:slime_paste_file = "$HOME/.slime_paste"
xmap <Leader>s <Plug>SlimeRegionSend
nmap <Leader>s <Plug>SlimeParagraphSend
" }}}
" настройка NERDTree {{{
" устнавливаем ширину колонки NERDTree
let g:NERDTreeWinSize = 20
" }}}

" " файлы для отката изменений будем хранить в отдельном каталоге
" if has('persistent_undo')
"     set undolevels=5000
"     set undodir=$HOME/.vim_undo
"     set undofile
" endif

" Let :w!! gain sudo privileges without closing and reopening vim
" cmap w!! w !sudo tee % >/dev/null

" modeline: в данном файле будут свернуты блоки между маркерами  {{{ и }}}
" vim:foldmethod=marker:foldlevel=0