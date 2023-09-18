#!/usr/bin/env bash

#-----------------------------------------------------------------------------|
# AUTOR             : Matheus Martins <3mhenrique@gmail.com>
# HOMEPAGE          : https://github.com/mateuscomh/qrbash
# DATE/VER.         : 16/09/2023 0.6
# LICENCE           : GPL3
# SHORT DESC        : Shell Script to generate and read QRCode from terminal
# DEPS              : zbarimg(zbar-tools), qrencode, scrot, xclip(optional)
#-----------------------------------------------------------------------------|

USAGE="Generate and read QR Codes from terminal

 ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄         ▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄            ▄           
▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░▌       ▐░▌▐░░░░░░░░░░░▌▐░▌          ▐░▌          
▐░█▀▀▀▀▀▀▀█░▌▐░█▀▀▀▀▀▀▀█░▌▐░█▀▀▀▀▀▀▀▀▀ ▐░▌       ▐░▌▐░█▀▀▀▀▀▀▀▀▀ ▐░▌          ▐░▌          
▐░▌       ▐░▌▐░▌       ▐░▌▐░▌          ▐░▌       ▐░▌▐░▌          ▐░▌          ▐░▌          
▐░▌       ▐░▌▐░█▄▄▄▄▄▄▄█░▌▐░█▄▄▄▄▄▄▄▄▄ ▐░█▄▄▄▄▄▄▄█░▌▐░█▄▄▄▄▄▄▄▄▄ ▐░▌          ▐░▌          
▐░▌       ▐░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░▌          ▐░▌          
▐░█▄▄▄▄▄▄▄█░▌▐░█▀▀▀▀█░█▀▀  ▀▀▀▀▀▀▀▀▀█░▌▐░█▀▀▀▀▀▀▀█░▌▐░█▀▀▀▀▀▀▀▀▀ ▐░▌          ▐░▌          
▐░░░░░░░░░░░▌▐░▌     ▐░▌            ▐░▌▐░▌       ▐░▌▐░▌          ▐░▌          ▐░▌          
 ▀▀▀▀▀▀█░█▀▀ ▐░▌      ▐░▌  ▄▄▄▄▄▄▄▄▄█░▌▐░▌       ▐░▌▐░█▄▄▄▄▄▄▄▄▄ ▐░█▄▄▄▄▄▄▄▄▄ ▐░█▄▄▄▄▄▄▄▄▄ 
        ▐░▌  ▐░▌       ▐░▌▐░░░░░░░░░░░▌▐░▌       ▐░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌
         ▀    ▀         ▀  ▀▀▀▀▀▀▀▀▀▀▀  ▀         ▀  ▀▀▀▀▀▀▀▀▀▀▀  ▀▀▀▀▀▀▀▀▀▀▀  ▀▀▀▀▀▀▀▀▀▀▀ 
                                                                                           
"
show_help() {
  echo -e "$USAGE"
  echo "Uso: $0 [string]"
  echo "No arguments: Decodes a QR code from a selected area on the screen."
  echo "With one argument: Generates a QR code from the provided string."
}

# Check deps
for check in 'zbarimg' 'qrencode' 'scrot'; do 
  type -P "$check" &>/dev/null || missing+="$check "; 
done 
[ -n "$missing" ] && echo "Please install: $missing" && exit 1

# Set temporary dir
TMPDIR="/dev/shm"
if [ ! -d "$TMPDIR" ]; then
  echo "/dev/shm não está disponível. Usando /tmp como alternativa."
  TMPDIR="/tmp"
fi
TMPFILE=$(mktemp "$TMPDIR/screenshot.XXXXXX.png")

# Main
echo -e "$USAGE"
if [ ! "$1" ]; then
  cd "$TMPDIR" || exit
  echo "Use mouse select an area on screen to decode QR"
  OUTPUT=$(scrot -s -e 'echo Image size $w x $h ; echo "" ; zbarimg "$f"')
  echo -e "$OUTPUT \n" | tee /dev/tty | sed -n "s/.*QR-Code://p" | xclip -selection clipboard >/dev/null
elif [ -f "$1" ]; then
  OUTPUT=$(zbarimg "$1")
  echo -e "$OUTPUT \n" | tee /dev/tty | sed -n "s/.*QR-Code://p" | xclip -selection clipboard >/dev/null
elif [ "$#" -eq 1 ]; then
  qrencode -m 2 -t ANSIUTF8 "$1" | tee "$TMPFILE"
else
  echo "Invalid input"; show_help
  exit 1
fi
