# source defaults

xrdb ~/.Xresources

if [ -d /etc/X11/xinit/xinitrc.d ]; then
        for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
                [ -x "$f" ] && . "$f"
        done
        unset f
fi

# start compton
compton -b

# start redshift
pgrep redshift &> /dev/null || redshift -l 19.285517:-99.175719 -t 5600:3400 &> /dev/null &

# start i3wm
exec i3

