export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"
sslocal -c ~/.ssrc &
exec cinnamon-session-cinnamon2d
# exec herbstluftwm --locked
# exec awesome
# exec lumina-desktop
# fcitx & #Support i3 chinese input
# exec i3
# xrdb -merge .Xresources
# xpmroot ~/background.xpm &
# xrandr -s 1440x900
# exec xmonad
# exec startkde
