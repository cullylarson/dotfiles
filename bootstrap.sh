#!/bin/bash

# c.f
# https://github.com/necolas/dotfiles
# https://github.com/mathiasbynens/dotfiles

DOTFILES_DIRECTORY="${HOME}/.dotfiles"

# Header logging
e_header() {
    printf "\n$(tput setaf 7)%s$(tput sgr0)\n" "$@"
}

# Success logging
e_success() {
    printf "$(tput setaf 64)✓ %s$(tput sgr0)\n" "$@"
}

# Error logging
e_error() {
    printf "$(tput setaf 1)x %s$(tput sgr0)\n" "$@"
}

# Warning logging
e_warning() {
    printf "$(tput setaf 136)! %s$(tput sgr0)\n" "$@"
}

# Ask for confirmation before proceeding
seek_confirmation() {
    printf "\n"
    e_warning "$@"
    read -p "Continue? (y/n) " -n 1
    printf "\n"
}

# Test whether the result of an 'ask' is a confirmation
is_confirmed() {
    if [[ "$REPLY" =~ ^[Yy]$ ]]; then
      return 0
    fi
    return 1
}

link() {
    # Force create/replace the symlink.
    ln -fs "${DOTFILES_DIRECTORY}/${1}" "${HOME}/${2}"
}

mirrorfiles() {
    # for vim swapfiles
    mkdir -p "${HOME}/.tmp/vim"

    link ".zshrc"        ".zshrc"
    link ".p10k.zsh"     ".p10k.zsh"
    link ".bashrc"       ".bashrc"
    link ".bash_profile" ".bash_profile"
    link ".bash_prompt"  ".bash_prompt"
    link ".aliases"      ".aliases"
    link ".exports"      ".exports"
    link ".functions"    ".functions"
    link ".vimrc"        ".vimrc"
    link ".tmux.conf"    ".tmux.conf"

    e_success "Dotfiles update complete!"
}

setupvim() {
    if [[ ! -d "${HOME}/.vim" ]]; then
        curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    fi
}


# Ask before potentially overwriting files
seek_confirmation "Warning: This step may overwrite your existing dotfiles."

if is_confirmed; then
    mirrorfiles
    setupvim
    source ${HOME}/.bash_profile
else
    printf "Aborting...\n"
    exit 1
fi
