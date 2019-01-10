
echo "####conf my .zshrc"
FLAG_COMMON=true
FLAG_HIGHSPEC=""
FLAG_PREZTO=true
FLAG_PECO=true
IS_CYGWIN=""
FLAG_UBUNTU=""
FLAG_VM=""
FLAG_SAKURA=""
FLAG_TMUX=true
FLAG_PYTHON=""
FLAG_RUBY=""
FLAG_GOLANG=true
FLAG_GOOGLE_CLOUD_SDK=""
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


case $HOST in
	PC) echo "##PC setup"
		if [ $IS_CYGWIN ];then
			echo "##this is  Cygwin"
			IS_CYGWIN=true
			function st() {
			    cygstart /cygdrive/c/Program\ Files/Sublime\ Text\ 3/sublime_text.exe `cygpath -aw $*` &
			}
			source /cygdrive/c/Users/tilmi/AppData/Local/Google/Cloud\ SDK/google-cloud-sdk/path.zsh.inc
			alias python='/cygdrive/c/Users/tilmi/home/.pyenv/versions/anaconda/envs/mypy/python.exe'
			alias pip=' /cygdrive/c/Users/tilmi/home/.pyenv/versions/anaconda/envs/mypy/Scripts/pip.exe'
			#PATH="/cygdrive/c/Users/tilmi/home/.pyenv/versions/anaconda/envs/mypy:/cygdrive/c/Users/tilmi/home/.pyenv/versions/anaconda/envs/mypy/Scripts/:$PATH"
		elif [ $IS_LINUX ];then
			echo "##this is Linux"
		fi
		FLAG_PREZTO=true
		FLAG_PYTHON=true
		FLAG_RUBY=""
		FLAG_HIGHSPEC=true
		FLAG_GOOGLE_CLOUD_SDK=true
		;;
	backuptower) echo "##backuptower setup"
		FLAG_PREZTO=true
		FLAG_UBUNTU=true
		FLAG_PYTHON=true
		FLAG_RUBY=true
		FLAG_HIGHSPEC=true
		;;
	macos.local) echo "##macos.local setup"
		FLAG_PREZTO=true
		;;
	ubuntumain*) echo "##ubuntumain setup"
		FLAG_PREZTO=true
		FLAG_UBUNTU=true
		FLAG_VM=true
		FLAG_PYTHON=true
		FLAG_RUBY=true
		FLAG_GOOGLE_CLOUD_SDK="true"
		;;
	ubuntusetuptest) echo "##ubuntusetuptest setup"
		FLAG_PREZTO=true
		FLAG_UBUNTU=true
		FLAG_VM=true
		FLAG_PYTHON=true
		FLAG_RUBY=true
		;;
	ubuntu-pcap) echo "##ubuntu-pcap setup"
		FLAG_PREZTO=true
		FLAG_UBUNTU=true
		FLAG_VM=true
		FLAG_PYTHON=true
		FLAG_RUBY=true
		FLAG_GOOGLE_CLOUD_SDK="true"
		FLAG_COMMON=true
		;;
	ubuntu-erico*) echo "##ubuntu-erico setup"
		FLAG_PREZTO=true
		FLAG_UBUNTU=true
		FLAG_VM=true
		FLAG_PYTHON=""
		FLAG_RUBY=true
		FLAG_GOOGLE_CLOUD_SDK="true"
		FLAG_COMMON=true
		export PYENV_ROOT="$HOME/.pyenv"
		export PATH="$PYENV_ROOT/versions/anaconda/bin/:$PYENV_ROOT/bin:$PATH"
		eval "$(pyenv init -)"
		alias activate-anaconda="source $HOME/.pyenv/versions/anaconda/bin/activate"
		alias deactivate-anaconda="source $PYENV_ROOT/versions/anaconda/bin/deactivate"
		activate-anaconda py3.6
		activate-anaconda py2.7
		PATH=$PATH:`chromedriver-path`
		;;
	www2271.sakura.ne.jp*) echo "##sakura setup"
		FLAG_SAKURA=true
		FLAG_PREZTO=true
		FLAG_GOOGLE_CLOUD_SDK=true
		FLAG_COMMON=true
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


if [ $FLAG_PYTHON ];then
	echo "##conf python"
	export PYENV_ROOT="$HOME/.pyenv"
	if [ $IS_CYGWIN ];then
		ANACONDA_ROOT="/cygdrive/c/Users/`whoami`/Anaconda3"
		export PATH="$ANACONDA_ROOT:$ANACONDA_ROOT/Scripts:$PATH"
		#	alias 'python'="$HOME/bin/winpty/build/winpty.exe python"
		#	alias 'ipython'="$HOME/bin/winpty/build/winpty.exe ipython"
	else
		export PATH="$PYENV_ROOT/versions/anaconda/bin/:$PYENV_ROOT/bin:$PATH"
		eval "$(pyenv init -)"
		alias activate-anaconda="source $HOME/.pyenv/versions/anaconda/bin/activate"
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

if [ $FLAG_UBUNTU ];then
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
	export PATH="$HOME/lib/python/bin:$PATH"
	export PYTHONPATH="$HOME/lib/python/lib/python3.6/site-packages"
	export LD_LIBRARY_PATH="$HOME/lib/python/lib"

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

echo "welcome to $HOST!!"

: <<'#__CO__'
if [ $ ];then
	echo "##"
fi
#__CO__



