
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

if [ `hostname` = "ubuntusetuptest" ]; then
	FLAG_UBUNTU=true
	FLAG_VM=true
fi



####

if [ $"{FLAG_COMMON}" ]; then
	echo "####set common"
	PATH=$HOME/bin:$PATH
fi


if [ $"{FLAG_UBUNTU}" ];then
	echo "####set ubuntu"
fi


: <<'#__CO__'
if [ $"{}" ];then
	echo "####"
fi
#__CO__


