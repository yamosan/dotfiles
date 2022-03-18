function _fzf_select_history() {
  BUFFER=$(history -n -r 1 | fzf --height=40% --border=rounded --query="$LBUFFER" --prompt="History > ")
  CURSOR=${#BUFFER}
  zle redisplay
}
zle -N _fzf_select_history
bindkey '^r' _fzf_select_history

function _fzf_select_git_switch() {
  search() {
    if [ -p /dev/stdin ]; then
      arg=$(cat /dev/stdin)
      if [ $COLUMNS -le 60 ]; then
        echo $(echo $arg | fzf --prompt="SWITCH BRANCH > ")
      elif [ $COLUMNS -le 80 ]; then
        echo $(echo $arg | fzf --min-height=10 --preview-window="bottom,90%" --prompt="SWITCH BRANCH > " --preview='f() { echo $1 | tr -d " *" | xargs git lgn --color=always }; f {}')
      else
        echo $(echo $arg | fzf --preview-window="right,65%" --prompt="SWITCH BRANCH > " --preview='f() { echo $1 | tr -d " *" | xargs git lgn --color=always }; f {}')
      fi
    fi
  }
  target_br=$(
    git branch -a | grep -v '^.*->.*$' |
      search |
      head -n 1 |
      perl -pe "s/\s//g; s/\*//g; s/remotes\/origin\///g"
  )
  if [ -n "$target_br" ]; then
    zle kill-buffer
    echo "git switch $target_br"
    git switch $target_br
    zle accept-line
  fi
}
zle -N _fzf_select_git_switch
bindkey "^g" _fzf_select_git_switch
