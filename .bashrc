# vim: set filetypet=sh
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples


## MacPorts vaatii ao. jutzkat
#export PATH=/opt/local/bin:/opt/local/sbin:$PATH
#export MANPATH=$MANPATH:/opt/local/share/man

export LC_MESSAGES="en_US.UTF-8"

if [[ $- != *i* ]] ; then
        # Shell is non-interactive.  Be done now!
        return
fi

# don't put duplicate lines in the history. See bash(1) for more options
# export HISTCONTROL=ignoredups

#enable color support of ls and also add handy aliases
export LSCOLORS="Exfxcxdxbxegedabagacad"
alias ls='ls -G -F'
alias grep='grep --color=auto'

#alias dir='ls --color=auto --format=vertical'
#alias vdir='ls --color=auto --format=long'

# some more ls aliases
alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'
alias h="history"

alias pylab='ipython --pylab'

alias config='/usr/bin/git --git-dir=$HOME/.myconf/ --work-tree=$HOME'

LESSOPEN="lessopen.sh %s"
LESSCLOSE="lessclose.sh %s %s"
export EDITOR=nvim
export VISUAL=$EDITOR

export XAUTHORITY=$HOME/.Xauthority
#export LANG="fi_FI.ISO8859-1"
#export LC_ALL="fi_FI.ISO8859-1"
export LANG="en_US.UTF-8"

# Colors
TXTBLU='\e[38;5;27m' # Blue

# get current branch in git repo
function parse_git_branch() {
    BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
    if [ ! "${BRANCH}" == "" ]
    then
	STAT=`parse_git_dirty`
	echo "[${BRANCH}${STAT}]"
    else
	echo ""
    fi
}

# get current status of git repo
function parse_git_dirty {
    status=`git status 2>&1 | tee`
    dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
    untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
    ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
    newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
    renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
    deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
    bits=''
    if [ "${renamed}" == "0" ]; then
	bits=">${bits}"
    fi
    if [ "${ahead}" == "0" ]; then
	bits="*${bits}"
    fi
    if [ "${newfile}" == "0" ]; then
	bits="+${bits}"
    fi
    # if [ "${untracked}" == "0" ]; then
    #     bits="?${bits}"
    # fi
    if [ "${deleted}" == "0" ]; then
	bits="x${bits}"
    fi
    if [ "${dirty}" == "0" ]; then
	bits="!${bits}"
    fi
    if [ ! "${bits}" == "" ]; then
	echo " ${bits}"
    else
	echo ""
    fi
}

function git {
    if [ $PWD == $HOME ]; then
	/usr/bin/git --git-dir=$HOME/.myconf/ --work-tree=$HOME "$@"
    else
	/usr/bin/git "$@"
    fi
}

# export MYPSDIR='$(echo -n "$PWD" | sed "s+/remote/projects/\(.\{12\}\).*/+\1/.../+")'
# export PS1="${TXTBLU}\$(parse_git_branch)\[\033[0m\]\[\033[1;33m\]@\h\[\033[0m\]:$(eval 'echo ${MYPSDIR}')$ ";
export PROMPT_DIRTRIM=3
# set a fancy prompt
#PS1='\u@\h:\w\$ '
PS1="\[$TXTBLU\]\$(parse_git_branch)\[\033[01;33m\]\u@\h:\[\033[00m\]\w\$ " #k‰ytt‰‰ kivoi v‰rei

# If this is an xterm set the TITLE of window  to user@host:dir
case $TERM in
xterm*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}: ${PWD/#$HOME/~}\007"'
;;
*)
;;
esac

shopt -s histverify
shopt -s nocaseglob
set completion-ignore-case on 

PATH="/usr/local/opt/gawk/libexec/gnubin:$PATH"

# Bind up/down & Ctrl P/N to search fucntions
# see: https://stackoverflow.com/a/1030206
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\C-p": history-search-backward'
bind '"\C-n": history-search-forward'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc).
. ~/.bash_complete
. ~/.git-completion.bash


# heroku autocomplete setup
HEROKU_AC_BASH_SETUP_PATH=/Users/lasse/Library/Caches/heroku/autocomplete/bash_setup && test -f $HEROKU_AC_BASH_SETUP_PATH && source $HEROKU_AC_BASH_SETUP_PATH;

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
