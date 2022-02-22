autoload -U colors && colors
autoload -Uz compinit && compinit

### insatall zinit
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


### plugins
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting

# bat
zinit ice as"program" from"gh-r" mv"bat* -> bat" pick"bat/bat"
zinit light sharkdp/bat

### fzf
zinit ice from"gh-r" as"command"
zinit light junegunn/fzf
zinit ice id-as"junegunn/fzf-completions" mv"shell/completion.zsh -> _fzf" src"shell/key-bindings.zsh" pick"/dev/null"
zinit light junegunn/fzf
function select-history() {
  BUFFER=$(history -n -r 1 | fzf --height=40% --layout=reverse --info=hidden --border=rounded --query="$LBUFFER" --prompt="History > ")
  CURSOR=${#BUFFER}
  zle redisplay
}
zle -N select-history
bindkey '^r' select-history

function select-git-checkout() {
  # https://www.rasukarusan.com/entry/2018/08/14/083000
  git checkout $(git branch -a | tr -d " " | fzf --select-1 --exit-0 --multi --layout=reverse --info=hidden --height=100% --prompt="CHECKOUT BRANCH > " --preview "git log --color=always {}" | head -n 1 | sed -e "s/^\*\s*//g" | perl -pe "s/remotes\/origin\///g")
  zle accept-line
}
zle -N select-git-checkout
alias gco='select-git-checkout'
# bindkey "^g" select-git-checkout

### starship
export STARSHIP_CONFIG=${HOME}/.starship.toml
zinit ice as"command" from"gh-r" \
          atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
          atpull"%atclone" src"init.zsh"
zinit light starship/starship

### asdf
zinit ice as"program" ver"v0.8.1" src"asdf.sh"
zinit light asdf-vm/asdf

### pipenv
export PIPENV_VENV_IN_PROJECT=true # プロジェクトディレクトリ配下に仮想環境を作成

### key bindings
stty stop undef # C-s での画面停止を無効

### history
export HISTFILE=${HOME}/.zsh_history    # ファイル名
export HISTSIZE=100000                  # ヒストリに保存するコマンド
export SAVEHIST=100000                  # 履歴ファイルに保存される履歴の件数
export HISTIGNORE=pwd:ls:la:ll:lla:exit # 以下のコマンドは記録しない(?や* も使える)
setopt append_history                   # HISTFILEを置き換えずに上書き
setopt hist_expire_dups_first           # 同じコマンドを履歴に追加したとき、最初に追加されたものを履歴から削除
setopt hist_ignore_all_dups             # 重複するコマンド行は古い方を削除
setopt hist_ignore_dups                 # 直前と同じコマンドは追加しない
setopt hist_no_store                    # historyコマンドは履歴に登録しない
setopt hist_reduce_blanks               # 余分な空白は詰める
setopt hist_ignore_space                # スペースで始まるコマンドは記録しない
setopt share_history                    # シェルのプロセスごとに履歴を共有

### zstyle
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'   # 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*:default' menu select=2          # 補完侯補をメニューから選択する。select=2: 補完候補を一覧から選択する。補完候補が2つ以上なければすぐに補完する。
zstyle ":completion:*:commands" rehash 1              # 新しいくインストールされたコマンドを即時認識
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} # ファイル補完候補ハイライト
zstyle ":history-search-multi-word" page-size "10"

### directory
setopt auto_cd             # ディレクトリ名のみで移動できる
setopt auto_pushd          # cd -[tab] で履歴
setopt pushd_ignore_dups   # 同じディレクトリはスタックしない
function chpwd() { ls -G } # 作業ディレクトリが変わるたびにlsを実行

### aliases
alias c='clear'
alias cdd='cd ~/Desktop'
alias relogin='exec $SHELL -l'
alias ls="ls -1G"
alias ll="ls -lG"
alias la="ls -laG"
alias d='docker'
alias dc='docker-compose'

