# My aliases
alias doc='cd ~/Documents/'
alias desk='cd ~/Desktop/'
alias down='cd ~/Downloads/'
alias sites='cd ~/Dropbox/Sites/'
alias decode='cd /Volumes/Documents/Archive/public/Decode'
alias ll='ls -l'
alias la='ls -a'

alias serve='python -m SimpleHTTPServer 8000'

alias myIP='curl ipecho.net/plain ; echo'


# Docker functions

dockercreate() {
  if [ $# -eq 0 ]
    then
      echo "Please supply VM name"
  else
    docker-machine create --driver virtualbox $1 \
    && docker-machine env $1 \
    && eval "$(docker-machine env $1)" \
    && docker-machine ls \
    && docker-machine ssh $1 'echo alias vim=\"docker run -ti --rm -v /Users/jasonellis/Dropbox/Sites/:/src jayellis/my_vim\" >> ~/.ashrc' \
    && docker-machine ssh $1 'echo alias resetDate=\"sudo ntpclient -s -h uk.pool.ntp.org\" >> ~/.ashrc' \
    && docker-machine ssh $1 'echo alias mongo=\"docker run -it --rm --link '$1'_mongo_1:mongo mongo bash -c '"\'"'mongo 192.168.99.100'"\'"'\" >> ~/.ashrc' \
    && docker-machine ssh $1
  fi
}

dockerstart() {
  if [ $# -eq 0 ]
    then
      echo "Please supply VM name"
  else
    docker-machine start $1 \
    && docker-machine env $1 \
    && eval "$(docker-machine env $1)"  \
    && docker-machine ls \
    && docker-machine ssh $1 'echo alias vim=\"docker run -ti --rm -v /Users/jasonellis/Dropbox/Sites/:/src jayellis/my_vim\" >> ~/.ashrc' \
    && docker-machine ssh $1 'echo alias resetDate=\"sudo ntpclient -s -h uk.pool.ntp.org\" >> ~/.ashrc' \
    && docker-machine ssh $1 'echo alias mongo=\"docker run -it --rm --link '$1'_mongo_1:mongo mongo bash -c '"\'"'mongo 192.168.99.100'"\'"'\" >> ~/.ashrc' \
    && docker-machine ssh $1
  fi
}

dockervim() {
  docker-machine ssh $1 'echo alias vim=\"docker run -ti --rm -v /Users/jasonellis/Dropbox/Sites/:/src jayellis/my_vim\" >> ~/.ashrc' \
  && docker-machine ssh $1
}

PATH=~/bin:$PATH
