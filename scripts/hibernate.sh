#!/bin/sh

#$1 in {pre, post}
#$2 in {resume, hibernate}
case $1/$2 in
  pre/*)
    # Put here any commands you want to be run when suspending or hibernating.
    # echo "test from /lib64/elogind/system-sleep/" >> /var/log/elogin.log
    echo 1,2 = "$1", "$2" >> /var/log/elogin.log
    # enable touchpad before hibernate (I use i3+plasma)
    # echo "Enabling touchpad before $1 $2" >>  /var/log/elogind.log
    # sudo -u aghriss -g aghriss -- qdbus org.kde.keyboard /modules/kded_touchpad org.kde.touchpad.enable 2>&1 | tee -a /var/log/elogind.log
    # status="$(sudo -u aghriss -g aghriss -- qdbus org.kde.keyboard /modules/kded_touchpad org.kde.touchpad.isEnabled)"
    # echo "Touchpad is now enabled: $status" >> /var/log/elogind.log
    ;;
  post/*)
    # Put here any commands you want to be run when resuming from suspension or thawing from hibernation.
    # echo "test from /lib64/elogind/system-sleep/" >> /var/log/elogin.log
    # echo 1,2 = "$1", "$2" >> /var/log/elogin.log
    echo "Running keyboard keymap edit $1 $2" >>  /var/log/elogind.log
    /etc/local.d/00_change_layout.start 2>&1 | tee -a /var/log/elogind.log
    ;;
esac 
