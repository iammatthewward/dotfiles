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

filetype plugin indent on " might not need this?

" Packages
"setup vim-plug {{{
call plug#begin('~/.local/share/nvim/plugged')

Plug 'joshdick/onedark.vim'
Plug 'itchyny/lightline.vim'
Plug 'sheerun/vim-polyglot'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-commentary'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-eslint', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-prettier', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
Plug 'mileszs/ack.vim'

call plug#end()

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" Colour support
if (has("termguicolors"))
    set termguicolors
endif

" Options required for lightline
let g:lightline = { 'colorscheme': 'onedark' }  " colourscheme
let g:onedark_hide_endofbuffer = 1              " hide end-of-buffer ~ lines
set laststatus=2                                " ensure status line always show
set noshowmode                                  " hide mode since lightline shows it anyway
set cursorline                                  " highlight the current line

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

" copy to system clipboard
noremap <C-y> "*y

" Press space to turn off highlighted search and clear search
:nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

set splitbelow              " create new vsplit below current buffer
set splitright              " create new vsplit right of current buffer

" File navigation
let g:netrw_liststyle = 1                       " set tree list view in netrw
let g:netrw_banner = 0                          " hide banner in netrw
autocmd FileType netrw setl bufhidden=wipe      " fix to prevent netrwtreelisting files
" shortcut - to open file navigation
:nnoremap - :E<CR>

" Buffer navigation
:nnoremap <C-n> :bnext<CR>
:nnoremap <C-p> :bprevious<CR>
:nnoremap <C-x> :bd<CR>

" coc-settings
" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

