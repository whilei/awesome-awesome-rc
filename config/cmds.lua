local _M = {
	screenshot_select = "sleep 0.5 && scrot '%Y-%m-%d-%H%M%S_$wx$h_screenshot.png' --quality 100 --silent --select --freeze --exec 'xclip -selection clipboard -t image/png -i $f;mv $f ~/Pictures/screenshots/'",
	screenshot_window = "sleep 0.5 && scrot '%Y-%m-%d-%H%M%S_$wx$h_screenshot.png' --quality 100 --silent --focused --exec 'xclip -selection clipboard -t image/png -i $f;mv $f ~/Pictures/screenshots/'",
	invert_colors     = "xrandr-invert-colors"
}

return _M