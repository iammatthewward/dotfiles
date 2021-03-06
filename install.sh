#!/usr/bin/env bash

DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

mkdir -p ~/.vim/{ftplugin,ftdetect}
ln -sfv "$DOTFILES_DIR/.alias" ~
ln -sfv "$DOTFILES_DIR/.gitconfig" ~
ln -sfv "$DOTFILES_DIR/.vim/ftdetect/cjs.vim" ~/.vim/ftdetect/cjs.vim
ln -sfv "$DOTFILES_DIR/.vim/ftdetect/ejs.vim" ~/.vim/ftdetect/ejs.vim
ln -sfv "$DOTFILES_DIR/.vim/ftplugin/json.vim" ~/.vim/ftplugin/json.vim
ln -sfv "$DOTFILES_DIR/.vim/ftplugin/yaml.vim" ~/.vim/ftplugin/yaml.vim
ln -sfv "$DOTFILES_DIR/.vim/ftplugin/javascript.vim" ~/.vim/ftplugin/javascript.vim
ln -sfv "$DOTFILES_DIR/.vim/ftplugin/javascript.vim" ~/.vim/ftplugin/javascript.vim
ln -sfv "$DOTFILES_DIR/.vimrc" ~
ln -sfv "$DOTFILES_DIR/.zshrc" ~
 ln -sfv "$DOTFILES_DIR/coc-vim-settings.json" ~/.config/nvim/coc-settings.json
ln -sfv "$DOTFILES_DIR/init.vim" ~/.config/nvim/init.vim
