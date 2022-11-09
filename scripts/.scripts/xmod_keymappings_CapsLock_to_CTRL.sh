# Set CapsLock key to Control (L) via xmodmap
xmodmap -e "clear lock"
xmodmap -e "clear control"
xmodmap -e "keycode 66 = Control_L"
xmodmap -e "add control = Control_L Control_R"
