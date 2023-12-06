FLAG_COMMON=true
FLAG_HIGHSPEC=""
FLAG_PREZTO=true
FLAG_PECO=true
IS_CYGWIN=""
FLAG_MOBAXTERM_COMMON=""
FLAG_SAKURA=""
FLAG_CONDA=""
FLAG_VM=""
FLAG_TMUX=true
FLAG_PYTHON=""
FLAG_RUBY=""
FLAG_GOLANG=true
FLAG_GOOGLE_CLOUD_SDK=""
FLAG_NVM=""

unameOut="$(uname -s)"
IS_CYGWIN=""
IS_MAC=""
IS_LINUX=""
case "${unameOut}" in
    CYGWIN*) echo "##this is Cygwin" && IS_CYGWIN=true;;
    Darwin*) echo "##this is macos" && IS_MAC=true;;
    Linux*) echo "##this is Linux" && IS_LINUX=true;;
    FreeBSD*) echo "##this is FreeBSD" && IS_LINUX=true;;
    *) echo "##this is neither Cygwin nor Linux. exit 1" && exit 1;;
esac
IS_UBUNTU=""
case "$unameOut" in
    *Ubuntu*) echo "##this is Ubuntu" && IS_UBUNTU=true;;
esac
## check Windows Subsystem for Linux
[ -e /proc/sys/fs/binfmt_misc/WSLInterop ] && IS_UBUNTU=true
IS_MOBAXTERM=""
if [ -e /home/mobaxterm ]; then
    IS_MOBAXTERM=true
    IS_CYGWIN=""
fi

case "$HOST" in
    PC | workingtower) echo "##PC or workingtower setup"
        FLAG_PREZTO=true
        FLAG_PYTHON=true
        FLAG_RUBY=""
        FLAG_HIGHSPEC=true
        FLAG_GOOGLE_CLOUD_SDK=true
        if [ "$IS_CYGWIN" ];then
            echo "##this is  Cygwin"
            IS_CYGWIN=true
            function st() {
                cygstart /cygdrive/c/Program\ Files/Sublime\ Text\ 3/sublime_text.exe "$(cygpath -aw "$*")" &
            }
            function code() {
                if [ -L "$*" ]; then
                    TARGET=$(readlink "$*")
                else
                    TARGET="$*"
                fi
                "/cygdrive/c/Users/$(whoami)/AppData/Local/Programs/Microsoft VS Code/bin/code" "$(cygpath -aw "$TARGET")" &
            }
            function hidemaru() {
                if [ -L "$*" ]; then
                    TARGET=$(readlink "$*")
                else
                    TARGET="$*"
                fi
                /cygdrive/c/Program\ Files\ \(x86\)/Hidemaru/Hidemaru.exe  "$(cygpath -aw "$TARGET")" &
            }
            source /cygdrive/c/Users/tilmi/AppData/Local/Google/Cloud\ SDK/google-cloud-sdk/path.zsh.inc
            export PATH="$HOME/lib/intel_mkl:$PATH"
            ANACONDA_ROOT="/cygdrive/c/Users/$(whoami)/Anaconda3"
            #export PATH="$ANACONDA_ROOT:$ANACONDA_ROOT/bin:$ANACONDA_ROOT/Scripts:$PATH"
            echo "activate py39"
            export PATH="$ANACONDA_ROOT/envs/py39:$ANACONDA_ROOT/envs/py39/Scripts:$PATH"
            #source $HOME/.pyenv/versions/anaconda/bin/activate py3.9
            echo "activate py27"
            #source $HOME/.pyenv/versions/anaconda/bin/activate py2.7
            export PATH="$ANACONDA_ROOT/envs/py27:$ANACONDA_ROOT/envs/py27/Scripts:$PATH"
            FLAG_PYTHON=""

            #alias python='/cygdrive/c/Users/tilmi/home/.pyenv/versions/anaconda/envs/mypy/python.exe'
            #alias pip=' /cygdrive/c/Users/tilmi/home/.pyenv/versions/anaconda/envs/mypy/Scripts/pip.exe'
            #PATH="/cygdrive/c/Users/tilmi/home/.pyenv/versions/anaconda/envs/mypy:/cygdrive/c/Users/tilmi/home/.pyenv/versions/anaconda/envs/mypy/Scripts/:$PATH"
            echo "which python3: $(which python3)"
            echo "which pip3: $(which pip3)"
            echo "which python: $(which python)"
            echo "which pip: $(which pip)"
            
        elif [ "$IS_UBUNTU" ];then
            echo "##this is Ubuntu"
        fi
        ;;
    backuptower) echo "##backuptower setup"
        FLAG_PREZTO=true
        IS_UBUNTU=true
        FLAG_PYTHON=""
        FLAG_RUBY=true
        #FLAG_HIGHSPEC=true
        FLAG_GOOGLE_CLOUD_SDK=true
        FLAG_COMMON=true
        ANACONDA_ROOT="${HOME}/.pyenv/versions/anaconda"
        echo "activate py3.7"
        #source $HOME/.pyenv/versions/anaconda/bin/activate py37
        export PATH="$ANACONDA_ROOT/envs/py37/bin:$ANACONDA_ROOT/envs/py37/Scripts:$PATH"
        echo "activate py2.7"
        #source $HOME/.pyenv/versions/anaconda/bin/activate py27
        export PATH="$ANACONDA_ROOT/envs/py27/bin:$ANACONDA_ROOT/envs/py27/Scripts:$PATH"
        PATH=$PATH:$(chromedriver-path)
        echo "which python3: $(which python3)"
        echo "which pip3: $(which pip3)"
        echo "which python: $(which python)"
        echo "which pip: $(which pip)"
        export PATH="/usr/local/cuda/bin:${PATH}}"
        export LD_LIBRARY_PATH="/usr/local/cuda/lib64:/usr/lib/x86_64-linux-gnu:${LD_LIBRARY_PATH}}"
        ;;
    macos.local) echo "##macos.local setup"
        FLAG_PREZTO=true
        ;;
    ubuntumain*) echo "##ubuntumain setup"
        FLAG_PREZTO=true
        IS_UBUNTU=true
        FLAG_CONDA=true
        FLAG_VM=true
        FLAG_PYTHON=true
        FLAG_RUBY=true
        FLAG_GOOGLE_CLOUD_SDK="true"

        alias rcode='rmate -p 52400'
        alias rst='rmate -p 52401'
        ;;
    ubuntusetuptest) echo "##ubuntusetuptest setup"
        FLAG_PREZTO=true
        IS_UBUNTU=true
        FLAG_VM=true
        FLAG_PYTHON=true
        FLAG_RUBY=true
        ;;
    ubuntu-pcap) echo "##ubuntu-pcap setup"
        FLAG_PREZTO=true
        IS_UBUNTU=true
        FLAG_VM=true
        FLAG_PYTHON=true
        FLAG_RUBY=true
        FLAG_GOOGLE_CLOUD_SDK="true"
        FLAG_COMMON=true
        ;;
    ubuntu-erico*) echo "##ubuntu-erico setup"
        FLAG_PREZTO=true
        IS_UBUNTU=true
        FLAG_VM=true
        FLAG_PYTHON=""
        FLAG_RUBY=true
        FLAG_GOOGLE_CLOUD_SDK=true
        FLAG_COMMON=true
        #export PYENV_ROOT="$HOME/.pyenv"
        #export PATH="$PYENV_ROOT/versions/anaconda/bin/:$PYENV_ROOT/bin:$PATH"
        #eval "$(pyenv init -)"
        echo "activate py3.6"
# source $HOME/.pyenv/versions/anaconda/bin/activate py3.6  # commented out by conda initialize
        echo "activate py2.7"
# source $HOME/.pyenv/versions/anaconda/bin/activate py2.7  # commented out by conda initialize
        PATH=$PATH:$(chromedriver-path)
        ;;
    www2271.sakura.ne.jp*) echo "##sakura setup"
        FLAG_SAKURA=true
        FLAG_PREZTO=true
        FLAG_GOOGLE_CLOUD_SDK=true
        FLAG_COMMON=true
        export PATH="${HOME}/local/bin:${PATH}}"
        ;;
    tilsys*) echo "##tilsys setup"
        FLAG_PREZTO=true
        FLAG_PECO=true
        FLAG_COMMON=true
        FLAG_PYTHON=true
        FLAG_TMUX=true
        ;;
    *-msi*) echo "##-msi setup"    
        if [ "$IS_CYGWIN" ];then
            echo "##this is Cygwin"
            FLAG_COMMON=true

            FLAG_CONDA=true
            ANACONDA_ROOT="$HOME/.pyenv/versions/anaconda_win"
            export PATH="$ANACONDA_ROOT/Library/bin:$PATH"
            echo "activate py37"
            export PATH="$ANACONDA_ROOT/envs/py37/:$ANACONDA_ROOT/envs/py37/scripts:$PATH"
            echo "activate py27"
            export PATH="$ANACONDA_ROOT/envs/py27/:$ANACONDA_ROOT/envs/py27/scripts:$PATH"
            FLAG_PYTHON=""
            echo "which python3: $(which python3)"
            echo "which pip3: $(which pip3)"
            echo "which python: $(which python)"
            echo "which pip: $(which pip)"
            FLAG_PYTHON=""

            function code() {
                if [ -L "$*" ]; then
                    TARGET=$(readlink "$*")
                else
                    TARGET="$*"
                fi
                "/cygdrive/c/Users/$(whoami)/AppData/Local/Programs/Microsoft VS Code/bin/code" "$(cygpath -aw "$TARGET")" &
            }
            function hidemaru() {
                if [ -L "$*" ]; then
                    TARGET=$(readlink "$*")
                else
                    TARGET="$*"
                fi
                /cygdrive/c/Program\ Files\ \(x86\)/Hidemaru/Hidemaru.exe  "$(cygpath -aw "$TARGET")" &
            }
        elif [ "$IS_UBUNTU" ];then
            echo "##this is Ubuntu"
            # compinit -u
            FLAG_CONDA=true
            ANACONDA_ROOT="$HOME/.pyenv/versions/anaconda_ubuntu"
            export PATH="$ANACONDA_ROOT/condabin:$PATH"
            echo "activate py37"
            export PATH="$ANACONDA_ROOT/envs/py37/bin:$PATH"
            echo "activate py27"
            export PATH="$ANACONDA_ROOT/envs/py27/bin:$PATH"
            FLAG_PYTHON=""
            echo "which python3: $(which python3)"
            echo "which pip3: $(which pip3)"
            echo "which python: $(which python)"
            echo "which pip: $(which pip)"
            ## for ns-3 vis
            export DISPLAY=:0.0
            export LIBG_ALWAYS_INDIRECT=1
        fi
        ;;
    *-SW*) echo "##-SW setup"    
        if [ "$IS_CYGWIN" ];then
            echo "##this is Cygwin"
            FLAG_COMMON=true
            ANACONDA_ROOT="$HOME/.pyenv/versions/anaconda_win"
            export PATH="$ANACONDA_ROOT/Library/bin:$PATH"
            echo "activate py38"
            export PATH="$ANACONDA_ROOT/envs/py38:$ANACONDA_ROOT/envs/py38/scripts:$PATH"
            FLAG_PYTHON=""
            echo "which python3: $(which python3)"
            echo "which pip3: $(which pip3)"
            FLAG_PREZTO=true
            function code() {
                if [ -L "$*" ]; then
                    TARGET=$(readlink "$*")
                else
                    TARGET="$*"
                fi
                "/cygdrive/c/Users/$(whoami)/AppData/Local/Programs/Microsoft VS Code/bin/code" "$(cygpath -aw "$TARGET")" &
            }
            function hidemaru() {
                if [ -L "$*" ]; then
                    TARGET=$(readlink "$*")
                else
                    TARGET="$*"
                fi
                /cygdrive/c/Program\ Files\ \(x86\)/Hidemaru/Hidemaru.exe  "$(cygpath -aw "$TARGET")" &
            }

        elif [ "$IS_MOBAXTERM" ];then
            echo "##this is MobaXterm"
            autoload -Uz promptinit
            promptinit
            FLAG_COMMON=""
            FLAG_MOBAXTERM_COMMON=true
            FLAG_PREZTO=true
            echo "FLAG_PREZTO: ${FLAG_PREZTO}"

            ANACONDA_ROOT="$HOME/.pyenv/versions/anaconda_win"
            export PATH="$ANACONDA_ROOT/Library/bin:$PATH"
            echo "activate py38"
            export PATH="$ANACONDA_ROOT/envs/py38:$ANACONDA_ROOT/envs/py38/scripts:$PATH"
            FLAG_PYTHON=""
            echo "which python3: $(which python3)"
            echo "which pip3: $(which pip3)"

            function code() {
                if [ -L "$*" ]; then
                    TARGET=$(readlink "$*")
                else
                    TARGET="$*"
                fi
                "/cygdrive/c/Users/$(whoami)/AppData/Local/Programs/Microsoft VS Code/bin/code" "$(cygpath -aw "$TARGET")" &
            }
            function hidemaru() {
                if [ -L "$*" ]; then
                    TARGET=$(readlink "$*")
                else
                    TARGET="$*"
                fi
                /cygdrive/c/Program\ Files\ \(x86\)/Hidemaru/Hidemaru.exe  "$(cygpath -w "$TARGET")" &
            }
        elif [ "$IS_UBUNTU" ];then
            echo "##this is Ubuntu"
            # compinit -u
            ANACONDA_ROOT="$HOME/.pyenv/versions/anaconda_ubuntu"
            echo "activate py37"
            export PATH="$ANACONDA_ROOT/envs/py37/bin:$PATH"
            echo "activate py27"
            export PATH="$ANACONDA_ROOT/envs/py27/bin:$PATH"
            FLAG_PYTHON=""
            echo "which python3: $(which python3)"
            echo "which pip3: $(which pip3)"
            echo "which python: $(which python)"
            echo "which pip: $(which pip)"
            ## for ns-3 vis
            export DISPLAY=:0.0
            export LIBG_ALWAYS_INDIRECT=1
        fi
        ;;
    leo-ac*) echo "## leo-ac*"
        FLAG_COMMON=true
        FLAG_PREZTO=true
        IS_UBUNTU=true
        FLAG_RUBY=true
				FLAG_NVM=true

        ANACONDA_ROOT="$HOME/.pyenv/versions/anaconda"
        echo "activate py310"
        export PATH="$ANACONDA_ROOT/envs/py310/bin:$PATH"
        echo "activate py27"
        export PATH="$ANACONDA_ROOT/envs/py27/bin:$PATH"
        FLAG_PYTHON=""
        echo "which python3: $(which python3)"
        echo "which pip3: $(which pip3)"
        echo "which python: $(which python)"
        echo "which pip: $(which pip)"

				export PATH=/usr/local/cuda/bin:$PATH
        export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH

        # alias rcode='rmate -p 52800'
        # alias rst='rmate -p 52801'
        ;;
    libra-ac* | pisces-ac* | aquarius-ac* | taurus-ac* | aries-ac*) echo "##libra-ac* | pisces-ac* | aquarius-ac* | taurus-ac* | aries-ac*"
        FLAG_COMMON=true
        FLAG_PREZTO=true
        IS_UBUNTU=true
        FLAG_RUBY=true
				FLAG_NVM=true

        ANACONDA_ROOT="$HOME/.pyenv/versions/anaconda"
        echo "activate py37"
        export PATH="$ANACONDA_ROOT/envs/py37/bin:$PATH"
        echo "activate py27"
        export PATH="$ANACONDA_ROOT/envs/py27/bin:$PATH"
        FLAG_PYTHON=""
        echo "which python3: $(which python3)"
        echo "which pip3: $(which pip3)"
        echo "which python: $(which python)"
        echo "which pip: $(which pip)"

        alias rcode='rmate -p 52800'
        alias rst='rmate -p 52801'
        ;;
    *) echo "##not registerd host. apply COMMON settings"
        FLAG_COMMON=true
        ;;
esac



####

if [ $FLAG_COMMON ]; then
    echo "##conf common"
    HISTFILE=~/.zsh_history
    HISTSIZE=1000000
    SAVEHIST=1000000
    export TERM=xterm-256color
    
    PATH=$HOME/bin:$PATH
    
    alias ls='ls -G'
    alias ll='ls -lhG'
    alias lla='ls -alhG'
    alias vi='vim'

    stty stop undef

    bindkey -e
    #bindkey "^R" history-incremental-search-backward

    autoload -Uz compinit
    compinit
fi

if [ $FLAG_MOBAXTERM_COMMON ]; then
    echo "##conf mobaxterm_common"
    HISTFILE=~/.zsh_history
    HISTSIZE=1000000
    SAVEHIST=1000000
    export TERM=xterm-256color
    
    PATH=$HOME/bin:$PATH
    
    alias ls='ls'
    alias ll='ls -lh'
    alias lla='ls -alh'
    alias vi='vim'

    stty stop undef

    bindkey -e
    #bindkey "^R" history-incremental-search-backward

    autoload -Uz compinit
    compinit
fi

if [ "$FLAG_PYTHON" ];then
    echo "##conf python"
    export PYENV_ROOT="$HOME/.pyenv"
    if [ $IS_CYGWIN ];then
        ANACONDA_ROOT="/cygdrive/c/Users/`whoami`/Anaconda3"
        export PATH="$ANACONDA_ROOT:$ANACONDA_ROOT/Scripts:$PATH"
        #    alias 'python'="$HOME/bin/winpty/build/winpty.exe python"
        #    alias 'ipython'="$HOME/bin/winpty/build/winpty.exe ipython"
    else
        export PATH="$PYENV_ROOT/versions/anaconda/bin/:$PYENV_ROOT/bin:$PATH"
        eval "$(pyenv init -)"
        alias activate-anaconda="source $PYENV_ROOT/versions/anaconda/bin/activate"
        alias deactivate-anaconda="source $PYENV_ROOT/versions/anaconda/bin/deactivate"
        activate-anaconda mypy > /dev/null 2>&1 || activate-anaconda py3.6 > /dev/null 2>&1 || activate-anaconda py3.7 > /dev/null 2>&1
    fi
fi


if [ $FLAG_PREZTO ];then
    echo "##conf prezto"
    if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
        source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
    fi
    [ `alias | grep rm=` ] && unalias rm
    setopt CLOBBER
    unsetopt alwaystoend
fi

if [ $FLAG_PECO ];then
    echo "##conf peco"
    function peco-src () {
        local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
        if [ -n "$selected_dir" ]; then
            BUFFER="cd ${selected_dir}"
            zle accept-line
        fi
        zle clear-screen
    }
    zle -N peco-src
    bindkey '^]' peco-src
fi

if [ $FLAG_TMUX ];then
    echo "##conf tmux"
    function precmd() {
        if [ ! -z $TMUX ]; then
        tmux refresh-client -S
        else
            dir="%F{cyan}%K{black} %~ %k%f"
            if git_status=$(git status 2>/dev/null ); then
                git_branch="$(echo $git_status| awk 'NR==1 {print $3}')"
                case $git_status in
                *Changes\ not\ staged* ) state=$'%{\e[30;48;5;013m%}%F{black} ± %f%k' ;;
                *Changes\ to\ be\ committed* ) state="%K{blue}%F{black} + %k%f" ;;
                * ) state="%K{green}%F{black} ✔ %f%k" ;;
                esac
                if [[ $git_branch = "master" ]]; then
                    git_info="%K{black}%F{blue}⭠ ${git_branch}%f%k ${state}"
                else
                    git_info="%K{black}⭠ ${git_branch}%f ${state}"
                fi
            else
                git_info=""
            fi
        fi
    }
fi

if [ $IS_CYGWIN ];then
    echo "##conf cygwin"
fi

if [ $IS_UBUNTU ];then
    echo "##conf ubuntu"
    [ subl ] && alias st=subl
fi

if [ $FLAG_VM ];then
    echo "##conf VM"
fi

if [ $FLAG_SAKURA ];then
    echo "##conf sakura"
    export MAILCHECK=0
    export PATH="$HOME/lib/google-cloud-sdk/bin/:$PATH"
    export PATH="$HOME/local/python-3.8.5/bin:$PATH"
fi

if [ $FLAG_RUBY ];then
    echo "##conf ruby"
    export PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(rbenv init -)"
fi

if [ $FLAG_GOLANG ];then
    echo "##conf golang"
    # for go lang
    if [ -x "`which go`" ]; then
        export GOPATH=$HOME/go
        export PATH="$GOPATH/bin:$PATH"
    fi
fi

if [ $FLAG_HIGHSPEC ];then
    echo "##conf highspec"
fi

if [ $FLAG_GOOGLE_CLOUD_SDK ];then
    echo "##setup google clud sdk"
    # The next line updates PATH for the Google Cloud SDK.
    if [ -f '$HOME/lib/google-cloud-sdk/path.zsh.inc' ]; then . '$HOME/lib/google-cloud-sdk/path.zsh.inc'; fi

    # The next line enables shell command completion for gcloud.
    if [ -f '$HOME/lib/google-cloud-sdk/completion.zsh.inc' ]; then . '$HOME/lib/google-cloud-sdk/completion.zsh.inc'; fi
fi

if [ $FLAG_CONDA ]; then
    if [ $IS_UBUNTU ]; then
        # # >>> conda initialize >>>
        # echo ">>> conda initialize >>>"
        # # !! Contents within this block are managed by 'conda init' !!
        # __conda_setup="$($ANACONDA_ROOT/bin/conda 'shell.zsh' 'hook' 2> /dev/null)"
        # if [ $? -eq 0 ]; then
        #     eval "$__conda_setup"
        # else
        #     if [ -f "$ANACONDA_ROOT/etc/profile.d/conda.sh" ]; then
        #         # . "$ANACONDA_ROOT/etc/profile.d/conda.sh"  # commented out by conda initialize
        #     else
        #         export PATH="$ANACONDA_ROOT/bin:$PATH"
        #     fi
        # fi
        # unset __conda_setup
        # # <<< conda initialize <<<
        # . "$ANACONDA_ROOT/etc/profile.d/conda.sh"  # commented out by conda initialize
        # conda activate base
    fi
fi

if [ $FLAG_NVM ];then
    echo "##conf nvm"
		export NVM_DIR="$HOME/.nvm"
		[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
		[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi

echo "welcome to $HOST!!"

