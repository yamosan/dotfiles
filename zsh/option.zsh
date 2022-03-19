autoload -Uz colors && colors
autoload -Uz compinit && compinit

stty stop undef # C-s での画面停止を無効

# history
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

# completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'   # 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*:default' menu select=2          # 補完侯補をメニューから選択する。select=2: 補完候補を一覧から選択する。補完候補が2つ以上なければすぐに補完する。
zstyle ':completion:*:commands' rehash 1              # 新しいくインストールされたコマンドを即時認識
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} # ファイル補完候補ハイライト

# directory
setopt auto_cd             # ディレクトリ名のみで移動できる
setopt auto_pushd          # cd -[tab] で履歴
setopt pushd_ignore_dups   # 同じディレクトリはスタックしない
function chpwd() { ls -G } # 作業ディレクトリが変わるたびにlsを実行
