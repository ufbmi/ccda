if [ -f /etc/bash_completion ]; then
    source /etc/bash_completion
fi

export MYSQL_PS1="(\u@\h) [\d]> "

alias ls='ls --color=auto'
alias lsa='ls -al'

alias cdd='cd ..'
alias dua='du -hcs'

alias db='mysql -u ccdaa -p123 ccdaa'
alias db_root='mysql -u root -p123'


alias ali='vim ~/aliases'
alias refresh='source ~/aliases'


alias grepa='ack-grep -i '

alias restart_apache='service apache2 restart'

alias conf_apache='vim /etc/apache2/sites-enabled/000-default'
alias log_apache_err='vim /var/log/apache2/error.log'


