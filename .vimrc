" explicitly use vim rather than vi
set nocompatible

" Core
set number                          " turn line numbers on
syntax on                           " turn on syntax highlighting
set expandtab                       " use spaces for tabs
set shiftwidth=4                    " spaces to use when auto indenting
set softtabstop=4                   " set tab to 4 spaces
set bs=2                            " allow backspace to delete over line breaks and tabbed indentation
set mouse=a                         " pass mouse scrolling control to vim
set so=999                          " keep cursor centered on scroll
set wildignore+=**/node_modules/**  " ignore node_modules when using vimgrep
:au FocusLost * :wa                 " autosave on focus lost
let mapleader = ","                 " set leader key

filetype plugin indent on 

" Packages
"setup vim-plug {{{
call plug#begin('~/.local/share/nvim/plugged')

Plug 'joshdick/onedark.vim'
Plug 'itchyny/lightline.vim'
Plug 'sheerun/vim-polyglot'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-commentary'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'mileszs/ack.vim'
Plug 'tpope/vim-surround'
Plug 'editorconfig/editorconfig-vim'
Plug 'elixir-editors/vim-elixir'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'pedrohdz/vim-yaml-folds'
Plug 'Yggdroot/indentLine'
Plug 'weirongxu/plantuml-previewer.vim'
Plug 'tyru/open-browser.vim'
" coc.nvm
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-prettier', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-eslint', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-yaml', {'do': 'yarn install --frozen-lockfile'}

call plug#end()

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" copy to system clipboard
noremap <leader>y "*y

" Colour support
if (has("termguicolors"))
    set termguicolors
endif

" Options required for lightline
let g:lightline = {
      \ 'colorscheme': 'onedark',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'currentfunction', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status',
      \   'currentfunction': 'CocCurrentFunction',
      \   'filename': 'LightlineFilename'
      \ },
      \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
      \ }

function! LightlineModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? '♤ ' : ''
endfunction

function! LightlineFilename()
  return ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
        \ ('' != expand('%:f') ? expand('%:f') : '[New File]') .
        \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction


" colourscheme
let g:onedark_hide_endofbuffer = 1              " hide end-of-buffer ~ lines
set laststatus=2                                " ensure status line always show
set noshowmode                                  " hide mode since lightline shows it anyway
set cursorline                                  " highlight the current line
" set wildmenu

" Colorscheme overrides
if (has("autocmd") && !has("gui_running"))
  augroup colorset
    autocmd!
    let s:white = { "gui": "#ABB2BF", "cterm": "145", "cterm16" : "7" }
    let s:black = { "gui": "#282c34", "cterm": "235", "cterm16" : "0" }
    let s:grey = { "gui": "#808A9D", "cterm": "244", "cterm16" : "8" }
    " use the terminal's background color (`bg` will not be styled since there is no `bg` setting)
    autocmd ColorScheme * call onedark#set_highlight("Normal", { "fg": s:white })

    " make line numbers more legible
    autocmd ColorScheme * call onedark#extend_highlight("LineNr", { "fg": s:grey })
    autocmd ColorScheme * call onedark#extend_highlight("CursorLineNr", { "fg": s:white })

    " less jarring search highlighting
    autocmd ColorScheme * call onedark#extend_highlight("Search", { "bg": s:white })
    autocmd ColorScheme * call onedark#extend_highlight("IncSearch", {  "fg": s:black, "bg": s:white })
  augroup END
endif

let g:onedark_terminal_italics = 1 " allow italics

colorscheme onedark

" Keybindings
" navigate between splits with ctrl+(h|j|k|l)
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" account for lazy shift fingers
:command W w
:command Q q
:command WQ wq
:command Wq wq

" Press space to turn off highlighted search and clear search
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

set splitbelow              " create new vsplit below current buffer
set splitright              " create new vsplit right of current buffer
nnoremap <silent> <leader>s :sp<CR>
nnoremap <silent> <leader>v :vsp<CR>
nnoremap <silent> <leader>q :q<CR>
nnoremap <silent> <leader>f :F<CR>

" File navigation
let g:netrw_liststyle = 1                       " set tree list view in netrw
let g:netrw_banner = 0                          " hide banner in netrw
autocmd FileType netrw setl bufhidden=wipe      " fix to prevent netrwtreelisting files

" shortcut - to open file navigation
nnoremap - :Explore<CR>

" Buffer navigation
nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bprevious<CR>
nnoremap <C-x> :enew \| bd#<CR>

" Grep shortcuts (using Ack)
nnoremap <silent> <leader>g :Ack!<space>

" COC settings
" TextEdit might fail if hidden is not set.
set hidden

" Quicker linting (ms)
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif


function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction


" Use <tab> and <S-tab> to navigate completion list: >
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" Insert <tab> when previous text is space, refresh completion if not.
inoremap <silent><expr> <TAB>
\ coc#pum#visible() ? coc#pum#next(1):
\ <SID>check_back_space() ? "\<Tab>" :
\ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" autocomplete with Enter
inoremap <expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<CR>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

" Add (Neo)Vim's native statusline support.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" LSP integrations
let g:ale_elixir_elixir_ls_release='~/elixir-ls/release'

" Folding
set foldmethod=syntax   " syntax highlighting items specify folds
set foldlevelstart=99   " ensure all folds are open when we open a file

" Set the indent line used in to Yggdroot/indentLine be a thinner line 
let g:indentLine_char = '⦙'
let g:indentLine_fileTypeExclude = ['markdown']

" stop netrw being unable to open long filenames
let g:netrw_maxfilenamelen=100
