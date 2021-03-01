#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'

# Colorful PS1 for root
if [ "$USER" = "root" ]; then
  PS1='[\[\033[01;91m\]\u\[\033[00m\]@\h \W]\$ '
else
  PS1='[\u@\h \W]\$ '
fi

# Use bash-completion, if available
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
  . /usr/share/bash-completion/bash_completion

# Alias definitions
if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi
