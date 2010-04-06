#!/bin/sh

function common_configure {
    # Export path
    export PATH=~/bin:$PATH
    export PATH=./bin:$PATH
    export PATH=$BASH_SCRIPTS_PATH/bin:$PATH
    
    # sledge hostname
    case `hostname` in
        HDU15109-Adigital-2.local) export HOSTNAME="hansolo";;
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

    # Show conrrent rvm use vm version
    # TODO: Display corrent rvm gems set
    function rvm_version {
        if [[ -f ~/.rvm/bin/rvm-prompt ]]; then
            RVM_VERSION=`~/.rvm/bin/rvm-prompt`
            GEM_SET="$(echo $GEM_PATH | awk -F'%' '{print $2}')"
            if [[ -f "$(pwd)/Rakefile" ]] && [[ ! -z "$RVM_VERSION" ]]; then
                echo "${RVM_VERSION} "
            fi
        fi
    }
    
    function rvm_gem_set {
        GEM_SET="$(echo $GEM_PATH | awk -F'%' '{print $2}')"
        if [[ -f "$(pwd)/Rakefile" ]] && [[ ! -z "$GEM_SET" ]]; then
            echo "(%${GEM_SET}) "
        fi
    }

    # TODO: Color themes
    PS1='\[\e[37m\][\[\e[31m\]\t\[\e[37m\]] \[\e[32m\]${HOSTNAME}:\[\e[37m\]\W \[\e[32m\]$(parse_git_branch)\[\e[33m\]$(rvm_version)$(rvm_gem_set)\[\e[37m\]\$\[\e[m\] '
    
    # Completation scripts
    source $BASH_SCRIPTS_LIBS/git-completion.bash
    complete -C $BASH_SCRIPTS_LIBS/rake-completion.rb -o default rake
    
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
}
