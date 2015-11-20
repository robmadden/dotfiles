# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias wscreen="screen -T xterm -c ~/.wscreenrc"
alias dv="dirs -v"
alias hgqa='hg status -madn|grep -v .txt|xargs flake8 --config=~/.config/pep8'
alias hgan="hg st | grep \? | cut -f2 -d' ' | xargs hg add"
alias hgfo="hg st | grep ! | cut -f2 -d' ' | xargs hg forget"
alias hgancestors="hg log -r 'ancestors(default) and not ancestors(stable)'"
alias hl="hg log | less"
alias hlo="hg log | less"
alias hlg="hg log | less"
alias hlog="hg log | less"
alias hlgo="hg log | less"
alias gl="git log | less"
alias glo="git log | less"
alias glog="git log | less"
alias glg="git log | less"
alias glgo="git log | less"
alias gg="git log --graph --decorate --oneline"
alias ..="cd .."
alias cd="venv_cd"
alias datafart='curl --data-binary @- datafart.com'

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

function collapse_pwd {
    echo $(pwd | sed -e "s,^$HOME,~,")
}

function prompt_char {
    git branch >/dev/null 2>/dev/null && echo '±' && return
    hg root >/dev/null 2>/dev/null && echo '☿' && return
    echo '○'
}

function battery_charge {
    echo `$BAT_CHARGE` 2>/dev/null
}

function virtualenv_info {
    [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`') '
}

function hg_prompt_info {
    hg prompt --angle-brackets "\
< on %{$fg[magenta]%}<branch>%{$reset_color%}>\
< at %{$fg[yellow]%}<tags|%{$reset_color%}, %{$fg[yellow]%}>%{$reset_color%}>\
%{$fg[green]%}<status|modified|unknown><update>%{$reset_color%}<
patches: <patches|join( → )|pre_applied(%{$fg[yellow]%})|post_applied(%{$reset_color%})|pre_unapplied(%{$fg_bold[black]%})|post_unapplied(%{$reset_color%})>>" 2>/dev/null
}

function gexport="git format-patch -1 $1"

tests() {
    output=`cat ~/.hgrc | egrep "^pre-push"`
    if [ $output != "" ];then
        echo "true"
    else
        echo "false"
    fi
}

PROMPT='
%{$fg[magenta]%}%n%{$reset_color%} at %{$fg[yellow]%}%m%{$reset_color%} in %{$fg_bold[green]%}$(collapse_pwd)%{$reset_color%}$(hg_prompt_info)$(git_prompt_info)
$(virtualenv_info)$(prompt_char) '

RPROMPT='$(battery_charge)'

ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%}!"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[green]%}?"
ZSH_THEME_GIT_PROMPT_CLEAN=""

export PATH=/usr/local/bin:$PATH:/usr/local/git/bin:/usr/local/mysql/bin:/opt/local/bin:/usr/local/sbin
export LIBMEMCACHED=/opt/local/

has_virtualenv() {
   if [ -e .venv ]; then
      workon `cat .venv`
   fi
}
venv_cd () {
   builtin cd "$@" && has_virtualenv
}

host() {
    cat /etc/hosts | grep $1
}

gitall() {
    git add . && git commit -m "$@" && git push origin master:master && git push heroku master
}

setopt nocorrectall;

[[ -s $HOME/.pythonbrew/etc/bashrc ]] && source $HOME/.pythonbrew/etc/bashrc

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
