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

# No duplicate lines or lines starting with space in the history
HISTCONTROL=ignoreboth:erasedups

# Enable Git prompt script
if [ -f /usr/share/git/completion/git-prompt.sh ]; then
  . /usr/share/git/completion/git-prompt.sh
fi

# Configure GPG-AGENT
GPG_TTY=$(tty)
export GPG_TTY

# Configure ssh-agent
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent -t 1h > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [[ ! -f "$SSH_AUTH_SOCK" ]]; then
    source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
fi

# Add ~/.local/bin to PATH
PATH=~/.local/bin:$PATH
