#!/bin/sh

source ~/scripts/src_dir_pull.sh

alias oracle='say $(fortune)'

alias ls='ls --color=auto'
function c() {
     if [ -d "$1" ]
     then
        cd $1
        ls
     fi
}
export conf='/Users/grahamcrocker/scripts/gpcrocker.sh'
alias recache='magerun index:reindex:all && magerun cache:flush'
alias cf=recache
alias ...="pushd ../../"
alias ....="pushd ../../../"
# your public ip
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
# your local ip
alias localip="ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p'"
alias weather="curl -s 'http://rss.accuweather.com/rss/liveweather_rss.asp?metric=1&locCode=en|uk|manchester' | sed -n '/Currently:/ s/.*: \(.*\): \([0-9]*\)\([CF]\).*/\2°\3, \1/p'"

alias revert_db=mage_full_revert_db

mage_full_revert_db() {
if [ -z "$1" ]
  then
    echo "Magento 1 Database Reverter" 
    echo "Error: No argument supplied"
    return -1
fi
if [ -f mage ]; then
    mysqladmin -uroot -f drop $1
    mysqladmin -uroot create $1
    magerun db:import --compression="gzip" ../databases/$1.sql.gz
    magerun admin:user:create admin admin admin admin admin 
    magerun sys:setup:run
    magerun index:reindex:all 
    littleboy
else
	echo 'not a mage dir'
fi
}

meteo() {
   clear
   if [ $# -eq 0 ]; then	
	city=manchester 
   else   
	city=$1
   fi
   finger $city'@graph.no' | lolcat
}

# Generates a tree view from the current directory
function tree(){
	pwd
	ls -R | grep ":$" |   \
	sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/   /' -e 's/-/|/'
}


function littleboy(){
if [ -f mage ]; then
	magerun cache:flush && rm -rf var/cache
else
	echo 'not a mage dir'
fi
}

function fatman() {
  if [ -f bin/magento ]; then
    rm -rf var/cache/
    rm -rf var/di
    rm -rf var/generation
    rm -rf var/page_cache
    bin/magento setup:upgrade
    bin/magento setup:di:compile
  else
    echo ‘Not an M2 dir’
  fi
}

alias qq='ls -GFlash'
alias debug-on='export XDEBUG_CONFIG=idekey=PHPSTORM; echo debug is on xdebug:$XDEBUG_CONFIG'
alias debug-off='unset XDEBUG_CONFIG; echo debug is off xdebug:$XDEBUG_CONFIG'
alias xdebug=debug-on
alias xdebug0=debug-off
EDITOR=/usr/bin/vim
VISUAL=/usr/bin/vim
export EDITOR VISUAL
