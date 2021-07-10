autoload -Uz colors && colors
autoload -U zmv

setopt auto_pushd # cd -[tab] で履歴
stty stop undef # C-s での画面停止を無効

# zsh-completions
fpath=(~/.zsh/completion $fpath)
autoload -Uz compinit && compinit

# LS_COLORSを設定しておく
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} # ファイル補完候補ハイライト
zstyle ':completion:*:default' menu select=2 # 補完侯補をメニューから選択する。select=2: 補完候補を一覧から選択する。補完候補が2つ以上なければすぐに補完する。


# history
# ファイル名
export HISTFILE=${HOME}/.zsh_history
# ヒストリに保存するコマンド
export HISTSIZE=100000
# 履歴ファイルに保存される履歴の件数
export SAVEHIST=10000000
# 以下のコマンドは記録しない(?や* も使える)
export HISTIGNORE=pwd:ls:la:ll:lla:exit
setopt hist_ignore_dups # 重複を記録しない
setopt share_history    # シェルのプロセスごとに履歴を共有
setopt append_history   # 複数の zsh を同時に使う時など history ファイルに上書きせず追加

# peco
function peco-select-history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(\history -n 1 | \
        eval $tac | \
        peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history


# starship 
export STARSHIP_CONFIG=~/.config/starship.toml
eval "$(starship init zsh)"



# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# nodenv
export PATH="$HOME/.nodenv/bin:$PATH"
eval "$(nodenv init -)"

# jenv
if which jenv > /dev/null; then
  # JENV_ROOTがemptyの場合、'${HOME}/.jenv'がrootと設定される
  export JENV_ROOT=/usr/local/var/jenv
  eval "$(jenv init -)"
fi

# pipenv
export PIPENV_VENV_IN_PROJECT=true # プロジェクトディレクトリ配下に仮想環境を作成

export PATH="/usr/local/sbin:$PATH"


# set Python's default version to 3.X
alias python='python3'
alias pip='pip3'

alias cdd='cd ~/Desktop'
alias relogin='exec $SHELL -l'
alias ls="ls -1G"
alias ll="ls -lG"
alias la="ls -laG"
