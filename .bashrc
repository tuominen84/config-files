
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

if [ -f ~/.aliases ]; then
	. ~/.aliases
fi

# Change default languege to english
export LANG=en_US.UTF-8

if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi

export EDITOR=vim

## # Allow X11 wiht sudo
## export XAUTHORITY="$HOME/.Xauthority"


# Activate project chooser
if [ -f /remote/soft/toolbox/local/bin/project-chooser.sh ]
then
    . /remote/soft/toolbox/local/bin/project-chooser.sh
fi

# Activate dir marks
if [ -f /remote/soft/toolbox/local/bin/directory-marks.sh ]
then
    . /remote/soft/toolbox/local/bin/directory-marks.sh
fi

#export MODULEPATH="$HOME/modulefiles"

#export PATH="$HOME/bin:$HOME/tb-scripts/:$PATH"

#module load local-soft/1.0
module load anaconda/2021.11

module load intel/ifort
module load abaqus/2019

#module load ansys/2020r2
#module load ansys/2019r2
module load ansys/2020r2
#module load star-ccm+/15.02.009_01_dp # This is version for Posiva Vettyminen
module load star-ccm+/16.06.008_01_dp

export PATH="/remote/soft/Ansys/AnsysWB/v2020R1/ansys_inc/shared_files/licensing/linx64:$PATH"

# Add own compiled programs into path
export PATH="$HOME/programs/bin:$PATH"

export PATH="$HOME/programs/git-2.21.3/bin/:$HOME/programs/git-2.21.3/libexec/git-core/:$PATH"

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
    gitcmd=$(which git)
    if [ $PWD == $HOME ]; then 
        $gitcmd --git-dir=$HOME/.myconf --work-tree=$HOME "$@"
    else
        $gitcmd "$@"
    fi
    
}

# set a fancy prompt (non-color, unless we know we "want" color)
color_prompt=yes
export PROMPT_DIRTRIM=3

if [ "$color_prompt" = yes ] && [ "$EUID" -ne 0 ] ; then
    PS1="\[$TXTBLU\]\$(parse_git_branch)\[\033[01;32m\]@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ "
else
    PS1='\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

function pwd_project {
    if [[ $PWD == /projects* ]]; then
        cpwd=$PWD
        cpwd=${cpwd##/projects/}
        #cpwd=${cpwd##/projects/projects}

        cpwd=${cpwd%%/*}
        echo "$cpwd"
    else
        echo "${PWD/#$HOME/~}"
    fi
}

PROMPT_COMMAND='printf "\033]0;%s: %s\007" "${HOSTNAME%%.*}" `pwd_project`'

## # Posia Vettyminen library 
## export LD_LIBRARY_PATH=/projects/Posiva/58098_Posiva_Vettyminen/c_libs/lib/
## 
## export PATH=/projects/Posiva/58098_Posiva_Vettyminen/09-Scripts:$PATH

# Bind up/down & Ctrl P/N to search fucntions
# see: https://stackoverflow.com/a/1030206
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\C-p": history-search-backward'
bind '"\C-n": history-search-forward'

shopt -s histverify
shopt -s histappend
export HISTTIMEFORMAT="%F %a %T "
PROMPT_COMMAND="$PROMPT_COMMAND ; history -a"
export HISTFILESIZE='unlimited'
export HISTSIZE=15000

shopt -s globstar # ** star glob pattersn

# # If this is an xterm set the title to user@host:dir
# case "$TERM" in
# xterm*|rxvt*)
#     #PS1="\[\e]0;@\h: \w\a\]$PS1"
#     #PS1="\[\e]0;\w@\h\a\]$PS1"
#     #PS1="\[\e]0;${PWD#/projects/projects/}@\h\a\]$PS1"
#     PS1="\[\e]0;${PWD#/projects/projects/}@\h\a\]$PS1"
# 
#     ;;
# *)
#     ;;
# esac

## Added by anaconda 2020.02 installer
## # >>> conda initialize >>>
## # !! Contents within this block are managed by 'conda init' !!
## __conda_setup="$('/remote/soft/Anaconda/anaconda3-2020.02/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
## if [ $? -eq 0 ]; then
##     eval "$__conda_setup"
## else
##     if [ -f "/remote/soft/Anaconda/anaconda3-2020.02/etc/profile.d/conda.sh" ]; then
##         . "/remote/soft/Anaconda/anaconda3-2020.02/etc/profile.d/conda.sh"
##     else
##         export PATH="/remote/soft/Anaconda/anaconda3-2020.02/bin:$PATH"
##     fi
## fi
## unset __conda_setup
## # <<< conda initialize <<<

