#!/usr/bin/env bash

#----------------------------------------------------|
#  Matheus Martins 3mhenrique@gmail.com
#  https://github.com/mateuscomh/qrshell
#  16/09/2023 1.0 GPL3 
#  Generate and read QRcode from terminal
#  Depends: zbar-tools, qrencode, scrot, xclip(opt)
#----------------------------------------------------|

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
         ▀    ▀         ▀  ▀▀▀▀▀▀▀▀▀▀▀  ▀         ▀  ▀▀▀▀▀▀▀▀▀▀▀  ▀▀▀▀▀▀▀▀▀▀▀  ▀▀▀▀▀▀▀▀▀▀▀ "
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

# Main
echo -e "$USAGE"
if [ ! "$1" ]; then
  cd "$TMPDIR" || exit
  echo "Use mouse select an area on screen to decode QR"
  OUTPUT=$(scrot -s -e 'echo Image size $w x $h ; echo "" ; zbarimg "$f"')
  echo -e "$OUTPUT \n" | tee /dev/tty | sed -n "s/.*QR-Code://p" | xclip -selection clipboard &>/dev/null
  sleep 1
elif [ -f "$1" ]; then
  OUTPUT=$(zbarimg "$1")
  echo -e "$OUTPUT \n" | tee /dev/tty | sed -n "s/.*QR-Code://p" | xclip -selection clipboard &>/dev/null
elif [ "$#" -eq 1 -a ! -f "$1" ]; then
  TMPFILE=$(mktemp "$TMPDIR/screenshot.XXXXXX.txt") 
  qrencode -m 2 -t ANSIUTF8 "$1" | tee "$TMPFILE" 
  cat "$TMPFILE" | zbarimg --quiet --raw - | qrencode -t ANSIUTF8
else
  echo "Invalid input"; show_help
  exit 1
fi
