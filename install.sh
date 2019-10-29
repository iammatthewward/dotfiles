#!/usr/bin/env bash

DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

ln -sfv "$DOTFILES_DIR/.alias" ~
ln -sfv "$DOTFILES_DIR/.gitconfig" ~
ln -sfv "$DOTFILES_DIR/.vim/ftplugin/javascript.vim" ~/.vim/ftplugin/javascript.vim
ln -sfv "$DOTFILES_DIR/.vim/ftplugin/elixir.vim" ~/.vim/ftplugin/elixir.vim
ln -sfv "$DOTFILES_DIR/.vim/ftplugin/css.vim" ~/.vim/ftplugin/css.vim
ln -sfv "$DOTFILES_DIR/.vim/ftplugin/json.vim" ~/.vim/ftplugin/json.vim
ln -sfv "$DOTFILES_DIR/.vim/ftplugin/terraform.vim" ~/.vim/ftplugin/terraform.vim
ln -sfv "$DOTFILES_DIR/.vimrc" ~
ln -sfv "$DOTFILES_DIR/.zshrc" ~
