set nocompatible
filetype off

call plug#begin()
Plug 'VundleVim/Vundle.vim'
Plug 'sheerun/vim-polyglot'
Plug 'cocopon/iceberg.vim'
Plug 'arcticicestudio/nord-vim'
Plug 'sickill/vim-monokai'
Plug 'jiangmiao/auto-pairs'
Plug 'preservim/nerdtree'
Plug 'preservim/tagbar'
Plug 'dyng/ctrlsf.vim'
Plug 'derekwyatt/vim-fswitch'
"Plug 'derekwyatt/vim-protodef'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
"Plug 'xavierd/clang_complete'
Plug 'mattesgroeger/vim-bookmarks'
call plug#end()

filetype plugin indent on

set nu     " Enable line numbers
syntax on  " Enable syntax highlighting
" How many columns of whitespace a \t is worth
set tabstop=8
" How many columns of whitespace a "level of indentation" is worth
set shiftwidth=8
" Use spaces when tabbing
set noexpandtab
"set expandtab
set incsearch  " Enable incremental search
set hlsearch   " Enable highlight search
set termwinsize=20x0   " Set terminal size
set splitbelow         " Always split below
set mouse=a            " Enable mouse drag on window splits

set background=dark
if has('gui_running')
	colorscheme monokai
else
	colorscheme monokai
endif

"
" Plugin Options
"
" auto-pairs
"let g:AutoPairsShortcutToggle = '<C-P>'

" NERDTree
let NERDTreeShowBookmarks = 1   " Show the bookmarks table
let NERDTreeShowHidden = 1      " Show hidden files
let NERDTreeShowLineNumbers = 0 " Hide line numbers
let NERDTreeMinimalMenu = 1     " Use the minimal menu (m)
let NERDTreeWinPos = "left"     " Panel opens on the left side
let NERDTreeWinSize = 31        " Set panel width to 31 columns
nmap <F2> :NERDTreeToggle<CR>

" tagbar
" Focus the panel when opening it
let g:tagbar_autofocus = 1
" Highlight the active tag
let g:tagbar_autoshowtag = 1
" Make panel vertical and place on the right
let g:tagbar_position = 'botright vertical'
" Mapping to open and close the panel
nmap <F8> :TagbarToggle<CR>

" ctrlsf
" Use the ack tool as the backend
let g:ctrlsf_backend = 'ack'
" Auto close the results panel when opening a file
let g:ctrlsf_auto_close = { "normal":0, "compact":0 }
" Immediately switch focus to the search window
let g:ctrlsf_auto_focus = { "at":"start" }
" Don't open the preview window automatically
let g:ctrlsf_auto_preview = 0
" Use the smart case sensitivity search scheme
let g:ctrlsf_case_sensitive = 'smart'
" Normal mode, not compact mode
let g:ctrlsf_default_view = 'normal'
" Use absoulte search by default
let g:ctrlsf_regex_pattern = 0
" Position of the search window
let g:ctrlsf_position = 'right'
" Width or height of search window
let g:ctrlsf_winsize = '46'
" Search from the current working directory
let g:ctrlsf_default_root = 'cwd'
" (Ctrl+F) Open search prompt (Normal Mode)
nmap <C-F>f <Plug>CtrlSFPrompt
" (Ctrl-F + f) Open search prompt with selection (Visual Mode)
xmap <C-F>f <Plug>CtrlSFVwordPath
" (Ctrl-F + F) Perform search with selection (Visual Mode)
xmap <C-F>F <Plug>CtrlSFVwordExec
" (Ctrl-F + n) Open search prompt with current word (Normal Mode)
nmap <C-F>n <Plug>CtrlSFCwordPath
" (Ctrl-F + o )Open CtrlSF window (Normal Mode)
nnoremap <C-F>o :CtrlSFOpen<CR>
" (Ctrl-F + t) Toggle CtrlSF window (Normal Mode)
nnoremap <C-F>t :CtrlSFToggle<CR>
" (Ctrl-F + t) Toggle CtrlSF window (Insert Mode)
inoremap <C-F>t <Esc>:CtrlSFToggle<CR>

" vim-fswitch
au! BufEnter *.cpp let b:fswitchdst = 'hpp,h'
au! BufEnter *.h let b:fswitchdst = 'cpp,c'
nmap <C-Z> :vsplit <bar> :wincmd l <bar> :FSRight<CR>

" fzf
"noremap <F9> <ESC>:FZF<CR>
noremap <C-p> :FZF<CR>
noremap <C-A-p> :Rg<CR>

" vim-protodef
" Pull in prototypes
"nmap <buffer> <silent> <leader> ,PP
" Pull in prototypes without namespace definition"
"nmap <buffer> <silent> <leader> ,PN

" clang_complete
"let g:clang_library_path='/usr/lib/llvm-10/lib/libclang.so.1'

" Get rid of arrows to get used to hjkl
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>
inoremap <Up> <nop>
inoremap <Down> <nop>
inoremap <Left> <nop>
inoremap <Right> <nop>

" No GUI interface
set guioptions=i
set guifont=DejaVu\ Sans\ Mono\ 8

" statusline
set laststatus=2

" Mappings
noremap <C-Tab> :tabnext<CR>
inoremap <C-Tab> <C-o>:tabnext<CR>
noremap <C-S-Tab> :tabprev<CR>
inoremap <C-S-Tab> <C-o>:tabprev<CR>

noremap <S-F9> :cnext<CR>
noremap <S-F10> :cprev<CR>

inoremap <A-d> <C-o>dw

" indent top-level block
nnoremap <F12> [[=%<C-o><C-o>

" commands

command Bd bp \| bd \#

" define line highlight color
highlight LineHighlight ctermbg=yellow ctermfg=black guibg=yellow guifg=black
" highlight the current line
nnoremap <silent> <Leader>l :call matchadd('LineHighlight', '\%'.line('.').'l')<CR>
" clear all the highlighted lines
nnoremap <silent> <Leader>c :call clearmatches()<CR>

" Current Line Highlight
set cursorline
highlight CursorLine cterm=NONE ctermbg=yellow ctermfg=black guibg=yellow guifg=black
highlight Cursor guifg=white guibg=black

au CmdlineEnter * hi Cursor guibg=darkgrey
au CmdlineLeave * hi Cursor guifg=white guibg=black

" C/C++ indentation
" :h cinoptions-values
set cino=g0,:4,l1,b0,E-s,t0,j1,(0,ws,Ws

" Clipboard 
" So you can yank and middle-click paste in other apps
set clipboard=unnamed

function CppHeader()
	let l:upperFileName = toupper(expand('%:t'))
	let l:defineName = substitute(l:upperFileName, '\.', '_', "g")
	put ='#ifndef ' . l:defineName 
	put ='#define ' . l:defineName
	put ='#endif // ' . l:defineName
	norm ggddGO
endfunction

function CtagsUpdate()
	!ctags -R --exclude='*.txt' --exclude='*.mk' --exclude='*.sh' --exclude='*.py' --exclude='Makefile' .
endfunction

" Enable Yocto syntax

function EnableYoctoSyntax()
	source ~/.vim/syntax/bitbake.vim
endfunction

function CheckYoctoPath()
	let l:path = expand('%')
	if (l:path =~ '.*/meta-.*') || (l:path =~ '^meta-.*')|| (l:path =~ '.*/build-.*')
		set filetype=yocto
	endif
endfunction

au BufRead,BufNewFile *.{bb,bbappend,bbclass} set filetype=yocto
au BufRead,BufNewFile *.{conf,inc} call CheckYoctoPath()

"au BufRead,BufNewFile *. call EnableYoctoSyntax()
au FileType yocto call EnableYoctoSyntax()


" Highlight all instances of word under cursor, when idle.
" Useful when studying strange source code.
" Type z/ to toggle highlighting on/off.
nnoremap z/ :if AutoHighlightToggle()<Bar>set hls<Bar>endif<CR>
function! AutoHighlightToggle()
  let @/ = ''
  if exists('#auto_highlight')
    au! auto_highlight
    augroup! auto_highlight
    setl updatetime=4000
    echo 'Highlight current word: off'
    return 0
  else
    augroup auto_highlight
      au!
      au CursorHold * let @/ = '\V\<'.escape(expand('<cword>'), '\').'\>'
    augroup end
    setl updatetime=500
    echo 'Highlight current word: ON'
    return 1
  endif
endfunction

