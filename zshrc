
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
FLAG_COMMON=true
FLAG_UBUNTU=false
FLAG_VM=false
FLAG_PYTHON=false
FLAG_RUBY=false

if [ hostname = backuptower ]; then
	FLAG_UBUNTU=true
fi

if [ `hostname` = "ubuntusetuptest" ]; then
	FLAG_UBUNTU=true
	FLAG_VM=true
	FLAG_PYTHON=true
	FLAG_RUBY=true
fi



####

if [ $"{FLAG_COMMON}" ]; then
	echo "####conf common"
	HISTFILE=~/.zsh_history
	HISTSIZE=1000000
	SAVEHIST=1000000

	PATH=$HOME/bin:$PATH
	
	alias ls~'ls -G'
	alias ll='ls -lhG'
	alias mkdir='mkdir -p'
	alias vi='vim'

fi


if [ $"{FLAG_UBUNTU}" ];then
	echo "####conf ubuntu"
fi


if [ $"{FLAG_VM}" ];then
	echo "####conf VM"
fi


if [ $"{FLAG_PYTHON}" ];then
	echo "####conf python"
	export PYENV_ROOT="$HOME/.pyenv"
	export PATH="$PYENV_ROOT/bin:$PATH"
	eval "$(pyenv init -)"
fi


if [ $"{FLAG_RUBY}" ];then
	echo "####conf ruby"
fi

: <<'#__CO__'
if [ $"{}" ];then
	echo "####"
fi
#__CO__


