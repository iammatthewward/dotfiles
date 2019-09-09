" explicitly use vim rather than vi
set nocompatible

" Core
set number              " turn line numbers on
syntax on               " turn on syntax highlighting
set expandtab           " use spaces for tabs
set shiftwidth=4        " spaces to use when auto indenting
set softtabstop=4       " set tab to 4 spaces
set bs=2                " allow backspace to delete over line breaks and tabbed indentation
set mouse=a             " pass mouse scrolling control to vim
set so=999              " keep cursor centered on scroll
:au FocusLost * :wa     " autosave on focus lost

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

call plug#end()

" Colour support
if (has("termguicolors"))
    set termguicolors
endif

" Options required for lightline
let g:lightline = { 'colorscheme': 'onedark' }  " colourscheme
set laststatus=2                                " ensure status line always show
set noshowmode                                  " hide mode since lightline shows it anyway

" onedark.vim override: Don't set a background color when running in a terminal;
" just use the terminal's background color
" `gui` is the hex color code used in GUI mode/nvim true-color mode
" `cterm` is the color code used in 256-color mode
" `cterm16` is the color code used in 16-color mode
if (has("autocmd") && !has("gui_running"))
  augroup colorset
    autocmd!
    let s:white = { "gui": "#ABB2BF", "cterm": "145", "cterm16" : "7" }
    autocmd ColorScheme * call onedark#set_highlight("Normal", { "fg": s:white }) " `bg` will not be styled since there is no `bg` setting
  augroup END
endif

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
:nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

set splitbelow              " create new vsplit below current buffer
set splitright              " create new vsplit right of current buffer

" File navigation
let g:netrw_liststyle = 3                       " set tree list view in netrw
let g:netrw_banner = 0                          " hide banner in netrw
autocmd FileType netrw setl bufhidden=wipe      " fix to prevent netrwtreelisting files

" Buffer navigation
:nnoremap <C-n> :bnext<CR>
:nnoremap <C-p> :bprevious<CR>

" Linting and fixing
let g:ale_fix_on_save = 1
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\}
let g:ale_sign_error = '✖'
let g:ale_sign_warning = '⚠'
