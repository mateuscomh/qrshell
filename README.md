
# QR Code Manipulation Script

``` bash
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
```
This script is a useful tool for working with QR codes directly via the terminal. It has the capability to both decode and generate QR codes.

## Objective

The main objective of this script is to provide a simple and effective command-line tool for:
1. Decoding QR codes from a selected area on the screen.
2. Generating visual representations of QR codes from provided strings.

## Features

1. **QR Code Decoding**: When executed without arguments, the script prompts the user to select an area on the screen. It then attempts to decode any QR code present in that area.

2. **QR Code Generation from File**: If the string provided as an argument is a file containing a QR code, it is printed to the terminal.

3. **QR Code Generation**: When provided with a string as an argument, the script generates and displays a QR code in the terminal.
   _If xclip is available (optional), QR code decoding outputs will be sent to the clipboard (Ctrl+C)._

## Dependencies

The script depends on the following tools:
- `zbarimg` (from zbar-tools): To decode QR codes from images.
- `qrencode`: To generate QR codes.
- `scrot`: To capture screenshots.
- (Optional) `xclip`: Receives QR code decoding results and sends them to the clipboard (Ctrl+C).

## Usage
- To decode a QR code from a screen area:
Without arguments: The script will attempt to decode a QR code from a screen area. *

```bash
./qrshell.sh
```
Then select the QR code on the screen.

- To generate a QR code
With a string as an argument: The script will generate a QR code from that string.
```bash
./qrshell.sh "your_string_here"
```

## License

This is free software: you can redistribute it and/or modify it under the terms of the [GNU General Public License (GPL)](LICENSE) as published by the Free Software Foundation.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
