
# <img src='AIY_logo_blue.png' card_color='#022B4F' width='50' height='50' style='vertical-align:bottom'/> Google AIY2 voicebonnet
Enables Google AIY2 voicebonnet

## About
This enables the LED and button on the Google AIY2 voicebonnet.

The button LED turns on when Mycroft is listening. If button is pressed he begins to listen. If the button is pressed for a longer time he stops whatever he is doing.

## Important
This skill is made for Picroft Buster Keaton which is Picroft on Rasbian Buster.

Tested with the Picroft image: Picroft Stable 2020-09-07 image, RPi 3, and AIY2

Once the skill is installed the script AIY2_install.sh must be run to load the voicebonnet python libraries that enable the LED.

### Installing the AIY2 voicebonnet
It is best to install by writing the Picroft image to the SD card, refuse guided setup, register the device, perform the upgrades, then install the skill:


```
msm install https://github.com/chiisaa/picroft-google-aiy2-voicebonnet-skill.git
```


Once the skill is installed, then run


```
sh mycroft-core/skills/picroft-google-aiy2-voicebonnet-skill.chiisaa/install_AIY2.sh
```


This script will add google's AIY repositories, update and install the necessary drivers and reconfigure the Pi to enable the board.
Be prepared, this will take a while depending on your internet connection.  Once it is finished, you need to reboot.

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
