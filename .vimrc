" запускаем pathogen, более удобный способ устанавливать плагины (каждый в отдельном каталоге)
execute pathogen#infect()

" автоматически перегружаем конфиг при его сохранении
nmap <silent> ;v :next $MYVIMRC<CR>
augroup VimReload
    autocmd!
    autocmd BufWritePost  $MYVIMRC  source $MYVIMRC
augroup END

" показывать номера строк
set number
" показывать парные скобки
set showmatch
" показывать найденное при наборе фразы для поиска
" не обращать внимание на регистр при поиске
" если в фразе для поиска есть большие буквы, обращать внимание на регистр
" подсвечивать найденное
set incsearch ignorecase smartcase hlsearch
" забой убирает подсветку найденных фраз
nmap <silent> <BS>  :nohlsearch<CR>
" заменять табуляции пробелами для всех файлов, кроме Makefile
set expandtab
autocmd FileType make setlocal noexpandtab

" " файлы для отката изменений будем хранить в отдельном каталоге
" if has('persistent_undo')
"     set undolevels=5000
"     set undodir=$HOME/.vim_undo
"     set undofile
" endif

" обновлять свап-файл каждые 10 строк (а не 200, как по умолчанию)
set updatecount=10

" подсветка синтаксиса
syntax on
filetype plugin indent on
" устанавливаем программу, вызываемую при выполнении команды make (нужно во FreeBSD)
set makeprg=gmake
set shiftwidth=4
set tabstop=4
" Настройки цветовой схемы
"let g:solarized_termcolors = 256
"let g:solarized_contrast = "normal"
"let g:solarized_italic=0
"let g:solarized_bold=0
set background=dark
"colorscheme eink
"colorscheme solarized
"colorscheme industry
colorscheme zenburn
" добавить русскую раскладку (переключение по ctrl+^)
set keymap=russian-jcukenwin
" использовать ее по умолчанию при запуске vim
set iminsert=0
set imsearch=0
" настройка курсора
if &term =~ "xterm" || &term =~ "screen"
    " blinking vertical bar
    let &t_SI .= "\<Esc>[5 q"
    " blinking block
    let &t_EI .= "\<Esc>[1 q"
endif
" бирюзовый курсор при включенной русской раскладке
highlight lCursor guifg=NONE guibg=Cyan cterm=none ctermfg=none ctermbg=214
" текущий каталог будет автоматически меняться при открытии файла, смене буффера и т.п.
set autochdir
" всегда показывать строку статуса
set laststatus=2
" показываем кодировку в строке статуса
if has("statusline")
    set statusline=%<%f\ %h%m%r%=%{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\ \"}%k\ %-14.(%l,%c%V%)\ %P
endif
" устнавливаем ширину колонки NERDTree
let g:NERDTreeWinSize = 20
" используем tmux для vim-slime
let g:slime_target = "tmux"
let g:slime_paste_file = "$HOME/.slime_paste"
xmap <Leader>s <Plug>SlimeRegionSend
nmap <Leader>s <Plug>SlimeParagraphSend

" Настройка радужных скобок
autocmd Syntax clojure RainbowParenthesesLoadRound
autocmd Syntax clojure RainbowParenthesesLoadSquare
"autocmd VimEnter RainbowParenthesesToggle
"autocmd BufEnter *.clj RainbowParenthesesToggle
"autocmd BufLeave *.clj RainbowParenthesesToggle
nmap <Leader>( :RainbowParenthesesToggle<CR>

" устанавливаем метод шифрования по умолчанию
set cryptmethod=blowfish

" Let :w!! gain sudo privileges without closing and reopening vim
" cmap w!! w !sudo tee % >/dev/null
