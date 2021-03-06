#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'

# Colorful PS1 for root
if [ "$USER" = "root" ]; then
  PS1='[\[\033[01;91m\]\u\[\033[00m\]@\h \W\[\033[38;5;136m\]$(__git_ps1 " (%s)")\[\033[00m\]]\$ '
else
  PS1='[\u@\h \W\[\033[38;5;136m\]$(__git_ps1 " (%s)")\[\033[00m\]]\$ '
fi

# Use bash-completion, if available
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
  . /usr/share/bash-completion/bash_completion

# Alias definitions
if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# Unlimited Bash history
HISTSIZE=-1
HISTFILESIZE=-1

# Enable Git prompt script
if [ -f /usr/share/git/completion/git-prompt.sh ]; then
  . /usr/share/git/completion/git-prompt.sh
fi
