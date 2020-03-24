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
Plug 'dense-analysis/ale'
Plug 'mileszs/ack.vim'
Plug 'tpope/vim-surround'

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
noremap <leader>y "*y

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
nnoremap - :E<CR>

" Buffer navigation
nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bprevious<CR>
nnoremap <C-x> :enew \| bd#<CR>


" Grep shortcuts (using Ack)
nnoremap <silent> <leader>g :Ack!<space>

" Linting and fixing
let g:ale_fix_on_save = 1
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\}
let g:ale_sign_error = '✖'
let g:ale_sign_warning = '⚠'
