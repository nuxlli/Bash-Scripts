#!/bin/sh

function common_configure {
    # Export path
    export PATH=~/bin:$PATH
    export PATH=./bin:$PATH
    export PATH=$BASH_SCRIPTS_PATH/bin:$PATH
    export PATH=$PATH:/Library/Frameworks/Mono.framework/Versions/Current/bin
    
    # sledge hostname
    case `hostname` in
        HDU15109-VPID.local) export HOSTNAME="hansolo";;
        *) export HOSTNAME=`hostname`;;
    esac

    # Vim configure
    alias gvim='mvim -g'
    alias tvim='mvim --remote-tab'

    # Alias e atalhos
    alias ll='ls -l'
    alias l='ll'
    alias la='ls -la'
    # alias ..="cd .."
    
    # Cria o diretorio e entra automatico nele
    mkdirg() { /bin/mkdir $@ && eval cd "\$$#"; }

    # Find
    alias psg='ps aux | grep'
    alias  gs='gem search'
    alias gsa='gem search --remote --source http://gems.abrdigital.com.br'
    alias gia='gem install --source http://gems.abrdigital.com.br'
    alias  hs='history | grep'

    # Profile
    alias eprofile='$EDITOR ~/.bash_profile'
    alias sprofile='source ~/.bash_profile'

    # Rails
    alias c='./script/console'
    alias s='./script/server'
    alias spec='spec -O ~/.rspecrc'
    
    # Git
    alias gitstrm='git st | grep deleted | sed '\''s/#//'\'' | sed '\''s/deleted://'\'' | xargs git rm'

    # History
    export HISTIGNORE='&:ls:lr:ll:[bf]g:pwd'
    export HISTCONTROL='ignoredups:erasedups'
    
    # Color grep
    export GREP_OPTIONS="--color=auto"
    export GREP_COLOR="4;33"
    export CLICOLOR="auto"
    
    # Man page configure
    if [[ -f "$(which most 2> /dev/null)" ]]; then
        export MANPAGER="$(which most) -s"
    fi

    # Ruby version manager
    if [[ -s ~/.rvm/scripts/rvm ]] ; then source ~/.rvm/scripts/rvm ; fi

    # Manhazinha pra o branch no prompt
    # http://blog.shadowmaru.org/2008/9/11/identificando-seu-branch-do-git-no-prompt
    function parse_git_branch {
        GIT_BRANCH=`git branch --no-color 2> /dev/null | cut -d "-" -f1-5 | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1) /'`
        if [[ ! -z "$GIT_BRANCH" ]]; then
            echo "${GIT_BRANCH}"
        fi
    }

    # Show corrent ruby version
    function __ruby_version {
        if [ ! -f ./Rakefile ] &&
            [ "$(find . -maxdepth 1 -name '*.rb' | head -n1)" == "" ]; then
            exit 1
        fi
        
        if [ -f ~/.rvm/bin/rvm-prompt ]; then
            rst=$(~/.rvm/bin/rvm-prompt $2 $3 $4 $5)
        fi
        
        if [ -z "$rst" ]; then
            rst=$(ruby -v | cut -f2 -d' ')
        fi
        
        fmt="ruby: %s"
        if [ -n "$1" ]; then
            fmt="$1"
        fi
        if [ -n "$rst" ]; then
            printf "$fmt" "${rst}"
        fi
    }

    # TODO: Color themes
    PS1='\[\e[37m\][\[\e[31m\]\t\[\e[37m\]] \[\e[32m\]${HOSTNAME}:\[\e[37m\]\W\[\e[32m\]$(__git_ps1) \[\e[33m\]$(__ruby_version)\[\e[37m\]\n\$\[\e[m\] '
    
    # Completation scripts
    source $BASH_SCRIPTS_LIBS/git-completion.bash
    complete -C $BASH_SCRIPTS_LIBS/rake-completion.rb -o default rake
    source $BASH_SCRIPTS_LIBS/gem_completion.sh
    
    # Auto CD
    source $BASH_SCRIPTS_LIBS/preexec.bash
    source $BASH_SCRIPTS_LIBS/functions.bash
    function preexec () {
        if [ `echo $BASH_COMMAND | wc -w` = '1' ] && [ ! `which $BASH_COMMAND` ]; then
            if [ -d $BASH_COMMAND ]; then
                cd $BASH_COMMAND
                return 1
            elif [ -r $BASH_COMMAND ]; then
                open $BASH_COMMAND
                return 1
            else
                return 0
            fi
        fi
    }

    preexec_install

    # Ant
    export ANT_OPTS="-Xmx512m"
    export JAVA_OPTS="-Xmx512m"
    
    # Mono
    export PKG_CONFIG_PATH=/Library/Frameworks/Mono.framework/Home/lib/pkgconfig:$PKG_CONFIG_PATH
    export PKG_CONFIG_PATH=/Library/Frameworks/Mono.framework/Versions/Current/lib/pkgconfig:$PKG_CONFIG_PATH
    #export PKG_CONFIG_PATH=`find /usr/local/Cellar -name pkgconfig | tail -r | sed -e :a -e '$!N; s/\n/:/; ta'`:$PKG_CONFIG_PATH
}
