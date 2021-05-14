
export PATH="/usr/local/bin:$PATH"
export HISTCONTROL=ignoredups


# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias composer="php /usr/local/bin/composer"

# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH";
export FIGNORE=$FIGNORE:DS_Store   
export EDITOR='vim'
#Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,bash_prompt,exports,functions,extra}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
	shopt -s "$option" 2> /dev/null;
done;

# Add tab completion for many Bash commands
if which brew > /dev/null && [ -f "$(brew --prefix)/etc/bash_completion" ]; then
	source "$(brew --prefix)/etc/bash_completion";
elif [ -f /etc/bash_completion ]; then
	source /etc/bash_completion;
fi;

# Enable tab completion for `g` by marking it as an alias for `git`
#if type _git &> /dev/null && [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
#	complete -o default -o nospace -F _git g;
#fi;

test -f ~/.git-completion.bash && . $_

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

# Add tab completion for `defaults read|write NSGlobalDomain`
# You could just use `-g` instead, but I like being explicit
complete -W "NSGlobalDomain" defaults;

# Add `killall` tab completion for common apps
complete -o "nospace" -W "Contacts Calendar Dock Finder Mail Safari iTunes SystemUIServer Terminal Twitter" killall;
export PATH=/usr/local/sbin:$PATH

#https://gist.github.com/jlekowski/2194155b7b885f6e2b60
alias ll='ls -alh'
alias git-update='git stash save tmp$(date +"%Y%m%d%H%M"); git pull --rebase; git stash pop; git lg -10'
alias phpx='PXDEBUG_CONFIG="idekey=PHPSTORM" PHP_IDE_CONFIG="serverName=VagrantXdebug" php -dxdebug.remote_host=10.12.6.92'   
 
function parse_git_branch () {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ \1/'
}
 
function parse_git_repo() {
    git remote -v 2> /dev/null | sed -e '/push/!d' -e '/origin/!d' -e 's/.*\/\(.*\).git .*/(\1: /'
}

function dirty(){
if [ -e ".git" ];then
    if [[ $(git status --porcelain)  ]];
        then 
	    echo -e -n '\033[1;31m'; 
        else 
            echo -e -n '\033[1;32m' 
    fi
fi
}

 
PS1='\[\033[1;31m\][\[\033[1;33m\]\u\[\033[1;31m\]:\[\033[1;36m\]\W\[\033[1;31m\]]$(dirty)$(parse_git_branch) \[\033[00m\]\$\[\033[00m\] '

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
### Added gradle
export PATH="$PATH:$HOME/java-tools/gradle-2.6/bin"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
