#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Aliases
alias st="subl"
alias st.="subl ."
alias code.="code ."
alias lock="xtrlock"
alias zshconfig="sublime3 ~/.zshrc ~/.zpreztorc"
alias dev="cd ~/dev"

# Git aliases
alias ga="git add"
alias gaa="git add --all"
alias gst="git status"
alias gb="git branch"
alias gco="git checkout"
alias gcd="git checkout develop"
alias gcm="git checkout master"
alias grb="git rebase"
alias grbd="git rebase develop"
alias grbm="git rebase master"
alias grbid="git rebase -i develop"
alias grbim="git rebase -i master"
alias gcmsg="git commit -m"
alias gd="git diff"
alias gdt="git difftool"
alias gf="git fetch"
alias grbc="git rebase --continue"
alias grba="git rebase --abort"
alias grhh="git reset --hard"
alias glog="git log --oneline --decorate --all --graph"

## These are functions, if they're aliases they try to evaluate git-branch-current on start.
function ggl() {
  git pull origin $(git-branch-current)
}

function ggpush() {
  git push origin $(git-branch-current) "$@"
}

# Source work-related evars and functions
if [[ -s "${ZDOTDIR:-$HOME}/.work-stuff" ]]; then
  source "${ZDOTDIR:-$HOME}/.work-stuff"
fi

export EDITOR=nvim

export GOPATH="$HOME/.go"
export PATH=~/.npm-global/bin:$GOPATH/bin:$PATH

alias snow="mpv ~/Videos/snow.mp4 --wid=0 --no-audio --loop &"
