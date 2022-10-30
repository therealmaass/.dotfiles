# Normal keyboard layout with german layout
# For reference: https://medium.com/@sean.nicholas/how-i-remapped-my-keyboard-to-have-a-better-developer-experience-1323424c62b8


# Numbers first row
xmodmap -e "keycode 17 = 8 bar"
#xmodmap -e "keycode 18 = 9 backslash"
# Special keys
# Umlaut
xmodmap -e "keycode 34 = braceleft braceright"
xmodmap -e "keycode 47 = parenleft parenright"
xmodmap -e "keycode 48 = bracketleft bracketright"
