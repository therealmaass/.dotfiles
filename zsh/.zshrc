# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/$USER/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#ZSH_THEME="robbyrussell"
ZSH_THEME="powerlevel10k/powerlevel10k"
# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	git
	cp
	history
	docker
	docker-compose
    sudo
    zsh-autosuggestions
	zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# User configuration
# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history
# Ranger Script: after exit Ranger switch to last ranger dir
source $HOME/.config/ranger/shell_automatic_cd
# WSL-Scripts: start ~/.wsl/startup.sh which starts necesseary services to run withoud sudo password auth:
# For NFS:
# - sudo service rpcbind start
# - sudo systemctl start rpcbind
# For automatic mlocate updatedb
# - sudo updatedb
# Look config files in /etc/sudoers.d/ dir for start without root auth
#source $HOME/.wsl/startup.sh
# Autocomplete hidden dotfiles:
_comp_options+=(globdots)
# vi mode  
bindkey -v
# vi mode: set jj to exit insert mode on commandline 
bindkey -M viins 'jj' vi-cmd-mode
# set KEYTIMEOUT to 25 miliseconds so that exit insert mode jj works 
export KEYTIMEOUT=25
# Enable explicit history backwards search due to bindkey -v configuration
bindkey '^R' history-incremental-search-backward
# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line
#Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char
export MANPATH="/usr/local/man:$MANPATH"
# Setting custom scripts folder into $PATH
PATH=$PATH:$HOME/.scripts
#eval "$(sh "$HOME/.wsl/eopen-ecd-0.12.0-x64/init.sh")"
#Set vim to default Editor
export VISUAL=vim
export EDITOR=vim
#Enable colors so that tmux sessions are colored
export TERM=xterm-256color
#Set bindkey for zsh-autosuggestions plugin
#https://github.com/zsh-users/zsh-autosuggestions
bindkey '^ ' autosuggest-accept
##########
#Aliases #
##########
#Open .zshrc in vim
alias zshconfig="vim ~/.zshrc"
#Open .tmux.conf in vim
alias tmuxconfig="vim ~/.tmux.conf"
alias rangerconfig="vim ~/.config/ranger/rc.conf"
# Set CapsLock key to behave like a CTRL key
alias capslockswap="setxkbmap -layout de -option ctrl:nocaps"
#List tmux sessions
alias tls="tmux ls"
#Attaches tmux to the last session; creates a new session if none exists
alias t="tmux attach || tmux new-session"
#Attaches tmux to a session (example: ta test)
alias ta="tmux attach -t"
#Opens windows user download folder on wsl2 machine
alias wdl="cd /mnt/d/user_soeren/Downloads"
#Opens windows explorer in current dir
alias we="explorer.exe ."
alias ranger="ranger_cd"
alias r="ranger_cd"
alias zshreload="source ~/.zshrc"
#Add -h parameter for du and df command
alias du="du -h"
alias df="df -h"
bindkey -s '^O' 'ranger_cd\n'
# Run WSL automount script
alias wslautomount="~/.scripts/wsl_automount.sh"
# ip in color
alias ip="ip --color=auto"
# cp with more information
alias cp="cp -iv"
# Set neovim (nvim) as a vim replacement
alias vim=nvim
alias v=nvim
alias tmm="~/.tmm_3.1.16.1/tinyMediaManager.sh"
# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
