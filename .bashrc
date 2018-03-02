# -----------------------------------------------------------------
# MODULES ENVIROMENT
# -----------------------------------------------------------------

## TCL_HOME="/remote/soft/support/tcl8"
## export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$TCL_HOME/lib:$TCL_HOME/lib/tclx8.4
## 
## MODULES_INIT_DIR="/remote/soft/support/Modules/default/init"
## MODULES_INIT_SHELL="$MODULES_INIT_DIR/bash"
## MODULES_BASH_COMPLETE="$MODULES_INIT_DIR/bash_completion"
## 
## if [ -f $MODULES_INIT_SHELL ]; then
##     . $MODULES_INIT_SHELL
## 
##     if [ -f MODULES_BASH_COMPLETE ]; then
##         . $MODULES_BASH_COMPLETE
##     fi
## 
##     #module add ansys/16.2
##     #module add ansys/17.2
##     module add ansys/18.1
## 
##     # module add star-ccm+/11.02.009_01_dp
##     # module add star-ccm+/11.04.010_01
##     # module add star-ccm+/11.06.010_02
##     module add star-ccm+/12.02.010_01
## 
##     module add ansa/16.1.1
## 
##     module add blender/2.76b-glibc212 
## 
##     module add meld/1.6.1
## 
##     module add local-soft/1.0
##     module add toolbox/1.0
##     module add toolbox_local/1.0
## fi

module load python 
module load mvapich2
module load OpenFOAM
#module load opt-elmer
# use below since 27.2.-18, because default isn't working
module load opt-elmer/Trafotek_16-02-18
module unload paraview/5.4.1
module load paraview/5.4.1

source $FOAM_ETC/bashrc

# -----------------------------------------------------------------
# ALIASES
# -----------------------------------------------------------------

# alias cp='cp -i'
# alias rm='rm -i'
# alias mv='mv -i'
alias ls='ls --color --time-style long-iso'
alias ll='ls -l'
# alias prj='cd /remote/projects'

[[ -f ~/.aliases ]] && . ~/.aliases

# -----------------------------------------------------------------
# ENVIRONMENT
# -----------------------------------------------------------------

export LC_COLLATE="C"
export HISTSIZE=4000
export HISTFILESIZE=$HISTSIZE

export PATH="${HOME}/bin:/sbin:${PATH}"
# Andritz scripts:
#export PATH="$PATH:/remote/projects/3020470_Andritz_DropletSpray_CFD/bin"
export CDPATH=.:/remote/projects/

export EDITOR="vim"
export BROWSER=/usr/bin/google-chrome

#export JAVA_HOME=/opt/jdk1.7.0_79
#export JRE_HOME=/opt/jdk1.7.0_79/jre
#export PATH=$PATH:/opt/jdk1.7.0_79/bin:/opt/jdk1.7.0_79/jre/bin

[ -x /usr/bin/lessfile ] && eval $(lessfile)

#umask 002

#export ICEM_ACN=/remote/soft/Ansys/AnsysWB/ansys_inc/v145/icemcfd/linux64_amd
#export PATH="$ICEM_ACN/bin:$PATH" 

# Added by Canopy installer on 2014-11-18
# VIRTUAL_ENV_DISABLE_PROMPT can be set to '' to make bashprompt show that Canopy is active, otherwise 1
# VIRTUAL_ENV_DISABLE_PROMPT=1 source /remote/home/lasset/Enthought/Canopy_64bit/User/bin/activate

# -----------------------------------------------------------------
# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
# -----------------------------------------------------------------
if [[ $- != *i* ]] ; then
        # Shell is non-interactive.  Be done now!
        return
fi

# -----------------------------------------------------------------
# KEY BINDINGS etc.
# -----------------------------------------------------------------

[[ -r $HOME/.xmodmap ]] && xmodmap $HOME/.xmodmap

case "$-" in
    *i*)
    bind '"\e[B": history-search-forward'
    bind '"\e[A": history-search-backward'
    ;;
esac

#[[ -f $HOME/programs/bash_completion ]] && . $HOME/programs/bash_completion

# Initialize z fuzzy completion
# . /remote/home/lasset/programs/z/z.sh

# Colors
TXTBLU='\e[38;5;27m' # Blue

# get current branch in git repo
function parse_git_branch() {
    BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
    if [ ! "${BRANCH}" == "" ]
    then
	STAT=`parse_git_dirty`
	echo -e "[${BRANCH}${STAT}]"
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
	/usr/bin/git $@
    fi
}

# export MYPSDIR='$(echo -n "$PWD" | sed "s+/remote/projects/\(.\{12\}\).*/+\1/.../+")'
#export PS1="\[$TXTBLU\]\$(parse_git_branch)\[\033[0m\]\[\033[1;33m\]@\h\[\033[0m\]:$(eval 'echo ${MYPSDIR}')$ ";
export PS1="\[$TXTBLU\]\$(parse_git_branch)\[\033[0m\]\[\033[1;33m\]@\h\[\033[0m\]:\w$ ";

# If this is an xterm set the title to user@host:dir${PWD/#$HOME/~}
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;@${HOSTNAME}: ${PWD/#$HOME/~}\007"'
    TERM=xterm-256color

    # Show the currently running command in the terminal title:
    # http://www.davidpashley.com/articles/xterm-titles-with-bash.html
    show_command_in_title_bar()
    {
        case "$BASH_COMMAND" in
            *\033]0*)
                # The command is trying to set the title bar as well;
                # this is most likely the execution of $PROMPT_COMMAND.
                # In any case nested escapes confuse the terminal, so don't
                # output them.
                ;;
            *)
                echo -ne "\033]0;@${HOSTNAME}: ${BASH_COMMAND}\007"
                ;;
        esac
    }
    trap show_command_in_title_bar DEBUG
    ;;
*)
    ;;
esac
# Above code copied from: http://askubuntu.com/questions/126737/make-gnome-terminal-show-the-command-running-as-title 

## TXTBLK='\e[0;30m' # Black - Regular
## TXTRED='\e[0;31m' # Red
## TXTGRN='\e[0;32m' # Green
## TXTYLW='\e[0;33m' # Yellow
## TXTPUR='\e[0;35m' # Purple
## TXTCYN='\e[0;36m' # Cyan
## TXTWHT='\e[0;37m' # White
## BLDBLK='\e[1;30m' # Black - Bold
## BLDRED='\e[1;31m' # Red
## BLDGRN='\e[1;32m' # Green
## BLDYLW='\e[1;33m' # Yellow
## BLDBLU='\e[1;34m' # Blue
## BLDPUR='\e[1;35m' # Purple
## BLDCYN='\e[1;36m' # Cyan
## BLDWHT='\e[1;37m' # White
## UNDBLK='\e[4;30m' # Black - Underline
## UNDRED='\e[4;31m' # Red
## UNDGRN='\e[4;32m' # Green
## UNDYLW='\e[4;33m' # Yellow
## UNDBLU='\e[4;34m' # Blue
## UNDPUR='\e[4;35m' # Purple
## UNDCYN='\e[4;36m' # Cyan
## UNDWHT='\e[4;37m' # White
## BAKBLK='\e[40m'   # Black - Background
## BAKRED='\e[41m'   # Red
## BAKGRN='\e[42m'   # Green
## BAKYLW='\e[43m'   # Yellow
## BAKBLU='\e[44m'   # Blue
## BAKPUR='\e[45m'   # Purple
## BAKCYN='\e[46m'   # Cyan
## BAKWHT='\e[47m'   # White
## TXTRST='\e[0m'    # Text Reset

#export PS1="\n\[$TXTRST\][\[$BLDRED\]\u@\h\[$TXTRST\] | \[$BLDWHT\]jobs: \[$TXTWHT\]\j\[$TXTRST\] | \[$BLDWHT\]\t \d\[$TXTRST\]]\n[\[$BLDGRN\]\w\[$TXTRST\]] (\[$TXTWHT\]\$(/bin/ls -1 | /usr/bin/wc -l | /bin/sed 's: ::g') files, \$(/bin/ls -lah | /bin/grep -m 1 total | /bin/sed 's/total //')) \[$BLDWHT\]> \[$TXTRST\]"

#export PS1="\[$TXTRST\]\[$BLDYLW\]@\h\[$TXTRST\]:\w$ "
#export PS1="@\h:\w$ "
#export MYPS='$(echo -n "${PWD/#$HOME/~}" | awk -F"/" "{if (NF>4) print ".../" $(NF-2) "/" $(NF-1) "/" $(NF); else print $0}")'

## Allaolevat ei toimi
## export MYPWD='$(echo -n "${PWD/#$HOME/~}" | awk -F "/" '"'"'{ if (NF>3) print ".../" $(NF-2) "/" $(NF-1) "/" $NF; else print $0}'"'"')'
## #echo $MYPWD
## export PS1='$(eval "echo \[$TXTRST\]\[$BLDYLW\]@\h\[$TXTRST\]:${MYPWD})"$ '


#if [ -f $HOME/.quotamsg ]; then
#        $HOME/.quotamsg
#fi

## if [ -f /remote/soft/toolbox/local/bin/project-chooser.sh ]
## then
##     . /remote/soft/toolbox/local/bin/project-chooser.sh
## fi

# added by Anaconda3 4.3.1 installer
# export PATH="/remote/home/lasset/anaconda3/bin:$PATH"

export PATH="~/prorams/VSCode-linux-x64/bin/:$PATH"
export PATH="~/git/external-module-dev/:$PATH"

source $HOME/my-environments/env/bin/activate


# vim:filetype=sh

