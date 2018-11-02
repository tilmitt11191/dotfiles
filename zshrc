
echo "welcome to $HOST!!"
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

# Customize to your needs...
echo "####conf my .zshrc"
FLAG_COMMON=true
FLAG_PREZTO=true
FLAG_UBUNTU=""
FLAG_CYGWIN=""
FLAG_VM=""
FLAG_PYTHON=""
FLAG_RUBY=""


if [ $HOST = PC ]; then
	echo "##PC setup"
	FLAG_CYGWIN=true
	FLAG_PYTHON=true
	FLAG_RUBY=true
fi

if [ $HOST = backuptower ]; then
	echo "backuptower"
	FLAG_UBUNTU=true
	FLAG_PYTHON=true
fi

if [ $HOST = "ubuntusetuptest" ]; then
	FLAG_UBUNTU=true
	FLAG_VM=true
	FLAG_PYTHON=true
	FLAG_RUBY=true
fi



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
	alias mkdir='mkdir -p'
	alias vi='vim'
fi


if [ $FLAG_PREZTO ];then
	echo "##conf prezto"
	[ `alias | grep rm=` ] && unalias rm
	setopt CLOBBER
fi

if [ $FLAG_UBUNTU ];then
	echo "##conf cygwin"
fi

if [ $FLAG_UBUNTU ];then
	echo "##conf ubuntu"
	[ subl ] && alias st=subl
fi


if [ $FLAG_VM ];then
	echo "##conf VM"
fi


if [ $FLAG_PYTHON ];then
	echo "##conf python"
	export PYENV_ROOT="$HOME/.pyenv"
	export PATH="$PYENV_ROOT/versions/anaconda/bin/:$PYENV_ROOT/bin:$PATH"
	eval "$(pyenv init -)"
	alias activate-anaconda="source $PYENV_ROOT/versions/anaconda/bin/activate"
	alias deactivate-anaconda="source $PYENV_ROOT/versions/anaconda/bin/deactivate"
	#source $PYENV_ROOT/versions/anaconda/bin/activate py3.7
fi


if [ $FLAG_RUBY ];then
	echo "##conf ruby"
fi

: <<'#__CO__'
if [ $ ];then
	echo "##"
fi
#__CO__


