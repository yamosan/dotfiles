# insatall zinit
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone -q https://github.com/z-shell/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

# End of Zinit's installer chunk


# plugins
zinit ice wait'0' lucid
zinit light zsh-users/zsh-completions
zinit ice wait'0' lucid
zinit light zsh-users/zsh-autosuggestions
zinit ice wait'0' lucid
zinit light zsh-users/zsh-syntax-highlighting

# starship
zinit ice from"gh-r" as"command" bpick'*tar.gz'\
    atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
    atpull"%atclone" src"init.zsh"
zinit light starship/starship

# bat
zinit ice wait'0' lucid as"command" from"gh-r" mv"bat* -> bat" pick"bat/bat"
zinit light sharkdp/bat

# exa
zinit ice wait'0' lucid as"command" from"gh-r" mv"completions/exa.zsh -> _exa" pick"bin/exa"
zinit light ogham/exa

# fzf
zinit ice wait'0' lucid from"gh-r" as"command"
zinit light junegunn/fzf

# asdf
zinit ice wait'0' lucid
zinit light asdf-vm/asdf

# ghq
zinit ice wait'0' lucid from"gh-r" as"command" mv"ghq* -> ghq" pick"ghq/ghq"
zinit light "x-motemen/ghq"
