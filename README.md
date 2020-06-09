
# <img src='AIY_logo_blue.png' card_color='#022B4F' width='50' height='50' style='vertical-align:bottom'/> Google AIY2 voicebonnet
Enables Google AIY2 voicebonnet

## About
This enables the led and button on the Google AIY2 voicebonnet.

The button led turns on when Mycroft is listning. If button is pressed he begins to listen. If the button is pressed for a longer time he stops whatever he is doing.

## Important
This skill is made for Picroft Buster Keaton which is Picroft on Rasbian Buster and should install and initialize "out of the box".

### Installing the AIY voicekit
If you haven't alreddy setup the voicebonnet, there is a script to help you do that in the skills folder.

run
```
install_AIY2.sh
```
This script will add google's AIY reposotories, update and install the necessary drivers and reconfigure the Pi to enable the board.
You need to do a reboot afterwards.

## Category
**IoT**

## Credits
Chip Isaacks (@chiisaa)
Thanks to Andreas Lorensen (@andlo) for doing the heavy lifting

## Supported Devices
platform_picroft

## Tags
#googlevoicebonnet
#aiy2
#Googleaiy2
#voicekitv2
#voicebonnet