autoload colors && colors
# cheers, @ehrenmurdick
# http://github.com/ehrenmurdick/config/blob/master/zsh/prompt.zsh

git_branch() {
  echo $(/usr/bin/git symbolic-ref HEAD 2>/dev/null | awk -F/ {'print $NF'})
}

git_dirty() {
  st=$(/usr/bin/git status 2>/dev/null | tail -n 1)
  if [[ $st == "" ]]
  then
    echo ""
  else
    if [[ $st == "nothing to commit (working directory clean)" ]]
    then
      echo "on %{$fg_bold[green]%}$(git_prompt_info)%{$reset_color%}"
    else
      echo "on %{$fg_bold[red]%}$(git_prompt_info)%{$reset_color%}"
    fi
  fi
}

git_prompt_info () {
 ref=$(/usr/bin/git symbolic-ref HEAD 2>/dev/null) || return
# echo "(%{\e[0;33m%}${ref#refs/heads/}%{\e[0m%})"
 echo "${ref#refs/heads/}"
}

unpushed () {
  /usr/bin/git cherry -v origin/$(git_branch) 2>/dev/null
}

need_push () {
  if [[ $(unpushed) == "" ]]
  then
    echo " "
  else
    echo " with %{$fg_bold[magenta]%}unpushed%{$reset_color%} "
  fi
}

rvm_prompt(){
  if $(which rvm &> /dev/null)
  then
	  echo "%{$fg_bold[yellow]%}$(rvm tools identifier)%{$reset_color%}"
	else
	  echo ""
  fi
}

hg_branch_info(){
  unset __CURRENT_HG_BRANCH
  unset __CURRENT_HG_BRANCH_STATUS
  unset __CURRENT_HG_BRANCH_IS_DIRTY
  local st="$(hg status 2>/dev/null)"
  local br="$(hg branch 2>/dev/null)"
  if [ -n "$br" ]; then
    local -a arr
    arr=(${(f)br})
    export __CURRENT_HG_BRANCH="$(echo $arr[1])"
  fi
  if [ -n "$st" ]; then
    if echo $st | grep "nothing to commit (working directory clean)" >/dev/null; then
    else
      export __CURRENT_HG_BRANCH_IS_DIRTY='1'
    fi
  fi
  
  if [ -n "$__CURRENT_HG_BRANCH" ]; then
    local s="("
    s+="$__CURRENT_HG_BRANCH"
    case "$__CURRENT_HG_BRANCH_STATUS" in
            ahead)
            s+="↑"
            ;;
            diverged)
            s+="↕"
            ;;
            behind)
            s+="↓"
            ;;
    esac
    if [ -n "$__CURRENT_HG_BRANCH_IS_DIRTY" ]; then
            s+="⚡"
    fi
    s+=")"
    
    printf "on %s%s" "%{${fg[yellow]}%}" $s
  fi
}

# This keeps the number of todos always available the right hand side of my
# command line. I filter it to only count those tagged as "+next", so it's more
# of a motivation to clear out the list.
todo(){
  if $(which todo.sh &> /dev/null)
  then
    num=$(echo $(todo.sh ls +next | wc -l))
    let todos=num-2
    if [ $todos != 0 ]
    then
      echo "$todos"
    else
      echo ""
    fi
  else
    echo ""
  fi
}

directory_name(){
  echo "%{$fg_bold[cyan]%}%1/%\/%{$reset_color%}"
}

export PROMPT=$'\n$(rvm_prompt) in $(directory_name) $(hg_branch_info)$(git_dirty)$(need_push)\n› '
set_prompt () {
  export RPROMPT="%{$fg_bold[cyan]%}$(todo)%{$reset_color%}"
}

precmd() {
  title "zsh" "%m" "%55<...<%~"
  set_prompt
}
