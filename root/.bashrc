# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Docker

# Ambari
source /root/ambari-functions

alias sshas='docker exec -it amb-server /bin/bash'
alias ssha1='docker exec -it amb1 /bin/bash'
alias ssha2='docker exec -it amb2 /bin/bash'
alias ssha3='docker exec -it amb3 /bin/bash'
