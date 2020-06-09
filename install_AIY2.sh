#!/bin/bash
echo "Installing Google AIY2 Voice Bonnet and microphone board (Voice Kit v2)"
# Get AIY2 drivers
if [ ! -f /etc/apt/sources.list.d/aiyprojects.list ]; then
    echo "adding aptsourses"
    echo "deb https://packages.cloud.google.com/apt aiyprojects-stable main" | sudo tee /etc/apt/sources.list.d/aiyprojects.list
    wget -q -O - https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
fi
echo "Updating and upgrading..."
sudo apt-get -y update
sudo apt-get -y upgrade

echo "installing what is needed..."
# hack to get aiy-io-mcu-firmware to be installed
sudo mkdir /usr/lib/systemd/system

sudo apt-get -y install aiy-dkms aiy-io-mcu-firmware aiy-vision-firmware dkms raspberrypi-kernel-headers
sudo apt-get -y install aiy-dkms aiy-voicebonnet-soundcard-dkms aiy-voicebonnet-routes
# this does for the moment gives problems on Picroft, and we (maybe) dont need it
#sudo apt-get -y install aiy-python-wheels
sudo apt-get -y install leds-ktd202x-dkms pwm-soft-dkms

echo "Installing Voice Bonnet packages"
sudo apt-get install -y aiy-voicebonnet-soundcard-dkms

echo "Disabling built-in audio"
sudo sed -i -e "s/^dtparam=audio=on/#\0/" /boot/config.txt

echo "Installing Pulse audio as it is needed..."
# we need pulseaudio
sudo apt-get -y install pulseaudio
sudo mkdir -p /etc/pulse/daemon.conf.d/
echo "default-sample-rate = 48000" | sudo tee /etc/pulse/daemon.conf.d/aiy.conf

echo "Make soundcard recognizable..."
# make soundcard recognizable
sudo sed -i \
    -e "s/^dtparam=audio=on/#\0/" \
    -e "s/^#\(dtparam=i2s=on\)/\1/" \
    /boot/config.txt
grep -q "dtoverlay=i2s-mmap" /boot/config.txt || \
sudo sh -c "echo 'dtoverlay=i2s-mmap' >> /boot/config.txt"
grep -q "dtoverlay=googlevoicebonnet-soundcard" /boot/config.txt || \
sudo sh -c "echo 'dtoverlay=googlevoicebonnet-soundcard' >> /boot/config.txt"
grep -q "dtparam=i2s=on" /boot/config.txt || \
sudo sh -c "echo 'dtparam=i2s=on' >> /boot/config.txt"

echo "Make changes to mycroft.conf"
# make changes to  mycroft.conf
sudo sed -i \
    -e "s/aplay -Dhw:0,0 %1/aplay %1/" \
    -e "s/mpg123 -a hw:0,0 %1/mpg123 %1/" \
    /etc/mycroft/mycroft.conf

echo "Install asound.conf..."
# Install asound.conf
if grep -q "default.ctl.card 0" "${FILE}" || grep -q "default.pcm.card 0" "${FILE}" || grep -q "default.pcm.device 0" "${FILE}" ; then
  echo "asound.conf alreddy OK"
else
  echo "defaults.ctl.card 0" | sudo tee --append /etc/asound.conf
  echo "defaults.pcm.card 0" | sudo tee --append /etc/asound.conf
  echo "defaults.pcm.device 0" |sudo tee --append /etc/asound.conf
fi

echo "Installing pip3"
sudo apt-get -y install python3-pip
sudo /home/pi/mycroft-core/.venv/bin/python -m pip install --upgrade pip

echo "Installing AIY Python Library"
sudo apt-get install -y git
git clone https://github.com/google/aiyprojects-raspbian.git AIY-projects-python
sudo pip3 install -e AIY-projects-python
cd AIY-projects-python
sudo cp -R src/aiy /home/pi/mycroft-core/.venv/lib/python3.7/site-packages/aiy
cd ..

echo "Installing RPi.GPIO"
sudo pip install RPi.GPIO

echo "Rebuild venv..."
# rebuild venv
/home/pi/mycroft-core/dev_setup.sh

echo "We are done - Reboot is needed !"
