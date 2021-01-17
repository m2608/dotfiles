" vim-plug {{{
" подключаем плагины
call plug#begin('~/.vim-plugged')

" цветовые темы
Plug 'altercation/vim-colors-solarized'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'axvr/photon.vim', { 'as' : 'photon' }

" выравнивание теста по разделителю
Plug 'godlygeek/tabular'

" сворачивание кода
Plug 'Konfekt/FastFold'

" отправка комманд в окна tmux
Plug 'jpalardy/vim-slime'
" используем tmux для vim-slime
let g:slime_target = "tmux"
let g:slime_paste_file = "$HOME/.slime_paste"
xmap <Leader>s <Plug>SlimeRegionSend
nmap <Leader>s <Plug>SlimeParagraphSend

" python repl
Plug 'sillybun/vim-repl'
" окно с repl откроется справа
let g:repl_position = 3
let g:repl_program = {'python': ['python'], 'default': ['python']}      
" при открытии repl не будет автоматически отправлять в него все импорты из
" файла
let g:repl_python_auto_import = 0
" объединяем многострочные строки при отправке в repl
let g:repl_python_automerge = 1
nnoremap <leader>r :REPLToggle<Cr>
" jupyter repl
" Для настройки сначала генерируем конфигурационные файлы:
"   jupyter console --generate-config
"   jupyter qtconsole --generate-config
" А потом включаем опции в конфигах в каталоге ~/.jupyter
" Для qtconsole:
"   c.ConsoleWidget.include_other_output = True
" Для console:
"   c.ZMQTerminalInteractiveShell.include_other_output = True
"Plug 'jupyter-vim/jupyter-vim'
"
" радужные скобки
Plug 'kien/rainbow_parentheses.vim'

" работа с таблицами
Plug 'dhruvasagar/vim-table-mode'

" плагин для удобного изменения тегов, кавычек
Plug 'tpope/vim-surround'

" навигация по файлам, проекту
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" устнавливаем ширину колонки NERDTree
let g:NERDTreeWinSize = 20
nnoremap <F2> :NERDTreeToggle<C-m>

Plug 'wincent/command-t'

" навигация по открытым буферам
Plug 'jlanzarotta/bufexplorer'

" работа с Clojure REPL
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" комментирование кода
Plug 'tomtom/tcomment_vim'

" подсветка синтаксиса и вызов AsciiDoctor
Plug 'habamax/vim-asciidoctor'

" поиск и замена в нескольких файлах
Plug 'pelodelfuego/vim-swoop'

" навигация по коду
Plug 'preservim/tagbar'
let g:tagbar_ctags_bin = '/usr/local/bin/uctags'
" вызов окна для навигации по коду (плагин tagbar)
nmap <F8> :TagbarToggle<CR>

" сниппеты
Plug 'SirVer/ultisnips'
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" синтаксис yaml
Plug 'stephpy/vim-yaml'

" синтаксис python (больше подсвечивает, чем синтаксис по умолчанию, например,
" f-строки)
Plug 'vim-python/python-syntax'
let g:python_highlight_all = 1

" автодополнение python
Plug 'davidhalter/jedi-vim'
" отключаем раздражающее окно с помощью при автодополнении
autocmd FileType python setlocal completeopt-=preview

" автодополнение с помощью Tab
Plug 'ervandew/supertab'

call plug#end()
" }}}
" определяем операционную систему {{{
if has("win32")
    let g:os = "Windows"
else
    let g:os = substitute(system("uname"),"\n","","")
endif
" }}}
" внешний вид {{{
" цветовая схема
set background=dark
" выключаем наклонный и жирный текст
" let g:solarized_italic = 0
" let g:solarized_bold = 0
" let g:solarized_underline = 0
" let g:solarized_termcolors=256

if $TERM == "xterm-mono"
    colorscheme default
else
    " colorscheme solarized
    "colorscheme manjaro_matcha_dark
    "colorscheme zenburn
    "let g:dracula_bold = 0
    "let g:dracula_italic = 0
    " прозрачность фона
    "let g:dracula_colorterm = 0
    "colorscheme dracula
    colorscheme photon
endif

" подсветка синтаксиса
syntax on
" выравнивание кода 
filetype plugin indent on
if exists('&modelineexpr')
    " если есть возможность отключения выражений в modeline, отключаем их (это
    " поведение по умолчанию)
    set modeline
    set nomodelineexpr
else
    " если такой опции нет, отключаем полностью modeline (в целях безопасности)
    set nomodeline
endif
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
" true color terminal
if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif
" }}}
" поиск {{{
" показывать найденное в процессе набора строки для поиска
set incsearch 
" если в строке для поиска нет больших букв - игнорировать регистр
set ignorecase
set smartcase 
" подсвечивать найденное
set hlsearch
" забой убирает подсветку найденных фраз
nmap <silent> <BS>  :nohlsearch<CR>
" }}}
" поиск файлов {{{
" команда :find будет искать файлы также и в подкаталогах
set path+=**
" }}}
" сворачивание кода {{{
" включить сворачивание
set foldenable
" используем пробел для сворачивания/разворачивания текущего блока
nnoremap <space> za
let g:markdown_folding=1
let g:markdown_foldlevel=0
function MyFoldText()
    let line = substitute(getline(v:foldstart),'{'.'{'.'{','','')
"    let num_lines = (v:foldend - v:foldstart + 1) . ' lines'
    return line . ' '
endfunction
set foldtext=MyFoldText()
" }}}
" поведение {{{
" обновлять свап-файл каждые 10 строк (а не 200, как по умолчанию)
set updatecount=10
" текущий каталог будет автоматически меняться при открытии файла, смене буффера и т.п.
"set oautochdir
" комбинация для открытия файла из текущего каталога
nnoremap <Leader>e :e <C-R>=expand('%:p:h') . '/'<CR>
" комбинация для смены текущего каталога на каталог, в котором лежит файл из
" открытого буфера
nnoremap <Leader>cd :lcd %:p:h<CR>:pwd<CR>
" хоткей для команды :find
nnoremap <Leader>f :find 
" следующее переназначение позволяет оставаться в визуальном режими при
" интердации выделенного блока с помощью < и >
vnoremap < <gv
vnoremap > >gv
" копирует в буфер обмена от положения курсора до конца строки (по аналогии с
" командами С и D)
noremap Y y$
" сочетания клавиш для режима вставки
inoremap <C-e> <C-o>$
inoremap <C-a> <C-o>^
" поиск слова под курсором
"nnoremap <F3> yiw/<C-r>0
nnoremap <F3> yiw:vimgrep /<C-r>0/ **/*
" переход между окнами
nnoremap <Tab> <C-w>w
nnoremap <S-Tab> <C-w>W
" устанавливаем программу, вызываемую при выполнении команды make (нужно во FreeBSD)
if g:os == "FreeBSD"
    set makeprg=gmake
endif
" для markdown команда будет преобразовывать файл с помощью pandoc
augroup markdown_pandoc
    autocmd!
    autocmd FileType markdown nnoremap <buffer><nowait><silent> <F9> :<c-u>call system('pandoc -f markdown -t html5 --toc -s '.expand('%:p').' -o '.expand('%:p:r').'.html && xdg-open '.expand('%:p:r').'.html')<cr>
augroup END
" используем ripgrep для поиска по файлам
set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
" автодополнение в строке команд
set wildmenu
" }}}
" локализация {{{
" добавить русскую раскладку (переключение по ctrl+^)
set keymap=russian-jcukenwin2
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
" настройка сохранения файлов undo {{{
" " файлы для отката изменений будем хранить в отдельном каталоге
" if has('persistent_undo')
"     set undolevels=5000
"     set undodir=$HOME/.vim_undo
"     set undofile
" endif
" }}}
" сохранение файла с sudo {{{
" Let :w!! gain sudo privileges without closing and reopening vim
if g:os == "FreeBSD"
    cmap w!! w !doas tee % >/dev/null
elseif g:os == "Linux"
    cmap w!! w !sudo tee % >/dev/null
endif
" }}}
" настройка терминала {{{
if g:os == "FreeBSD"
    set shell=/usr/local/bin/bash
elseif g:os == "Linux"
    set shell=/bin/bash
endif
" }}}
" asciidoc {{{
let g:asciidoctor_folding = 1
let g:asciidoctor_fold_options = 1
let g:asciidoctor_fenced_languages = ['python', 'perl', 'clojure', 'lua', 'sh', 'yaml']
" Function to create buffer local mappings
fun! AsciidoctorMappings()
    nnoremap <buffer> <leader>oo :AsciidoctorOpenRAW<CR>
    nnoremap <buffer> <leader>op :AsciidoctorOpenPDF<CR>
    nnoremap <buffer> <leader>oh :AsciidoctorOpenHTML<CR>
    nnoremap <buffer> <leader>ox :AsciidoctorOpenDOCX<CR>
    nnoremap <buffer> <leader>ch :Asciidoctor2HTML<CR>
    nnoremap <buffer> <leader>cp :Asciidoctor2PDF<CR>
    nnoremap <buffer> <leader>cx :Asciidoctor2DOCX<CR>
endfun

" Call AsciidoctorMappings for all `*.adoc` and `*.asciidoc` files
augroup asciidoctor
    au!
    au BufEnter *.adoc,*.asciidoc call AsciidoctorMappings()
augroup END
" }}}
" windows-специфичные настройки {{{
if g:os == "Windows"
    set guifont=ibm\ 3270\ narrow:h16:cRUSSIAN
    set guioptions-=T
    set guioptions-=r
    set fenc=utf-8
    set fileencodings=utf-8,cp1251,koi8-r,cp866
    let g:printencoding="cp1251"
    set iskeyword=@,a-z,A-Z,48-57,_,128-175,192-255
endif
" }}}

" modeline: в данном файле будут свернуты блоки между маркерами  {{{ и }}}
" vim:foldmethod=marker:foldlevel=0
