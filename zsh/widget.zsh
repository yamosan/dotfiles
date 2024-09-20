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
        echo $(echo $arg | fzf --min-height=10 --preview-window="bottom,90%" --prompt="SWITCH BRANCH > " --preview="echo {} | tr -d ' *' | xargs git lgn --color=always")
      else
        echo $(echo $arg | fzf --preview-window="right,65%" --prompt="SWITCH BRANCH > " --preview="echo {} | tr -d ' *' | xargs git lgn --color=always")
      fi
    fi
  }

  print_recently_checked_out_branches() {
    git --no-pager reflog | awk '$3 == "checkout:" && /moving from/ {print $8}' | awk '!a[$0]++{print}' | head
  }

  print_all_branches() {
    git branch -a | grep -v '^.*->.*$' | sed 's/^..//'
  }

  print_search_args() {
    (
      print_recently_checked_out_branches &&
      echo &&
      print_all_branches
    ) | awk '!a[$0]++{if(NR==1) print "* " $0; else print "  " $0}'
  }

  target_br=$(
    print_search_args |
      search |
      head -n 1 |
      perl -pe "s/\s//g; s/\*//g; s/remotes\/origin\///g"
  )
  if [ -n "$target_br" ]; then
    BUFFER="git switch $target_br"
    zle accept-line
  fi
}
zle -N _fzf_select_git_switch
bindkey "^s" _fzf_select_git_switch

function _fzf_select_ghq_cd() {
  local dest
  dest="$(ghq list | fzf)"

  if [ -n "$dest" ]; then
    BUFFER="cd $(ghq root)/$dest"
    zle accept-line
  fi
  zle redisplay
}
zle -N _fzf_select_ghq_cd
bindkey "^g" _fzf_select_ghq_cd
