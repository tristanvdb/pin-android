
if [ -e android-pin.rc ]
then
  source android-pin.rc
else
  echo "Ressource file android-pin.rc is missing..."
  exit
fi

#
# Usage: install-pin.sh api pin
#           > api \in 17
#                     18
#                     19
#                     21
#           > pin \in 2.13-65163-gcc.4.6
#                     2.14-67254-gcc.4.6
#                     2.14-71313-gcc.4.6
#                     2.14-71313-gcc.4.9
#

if [ ! `adb devices | grep device$ | wc -l` -eq 0 ]
then
  echo "Close all running emulator to start..."
  while [ ! `adb devices | grep device$ | wc -l` -eq 0 ]; do sleep 1; done
fi

# Launch the virtual device
emulator -avd device-$1 &

while [ `adb devices | grep device$ | wc -l` -eq 0 ]; do sleep 1; done

# Install busybox, used for its 'tar' utility.
adb -e push busybox-i686 /data/
adb -e shell "chmod 775 /data/busybox-i686"

# Install the different version of Pin
if [ -e pin-$pin_version-android/android-install.tar.gz ]
then
  adb -e shell rm -rf /data/pin-$pin_version
  adb -e shell mkdir -p /data/pin-$pin_version
  adb -e push pin-$pin_version-android/android-install.tar.gz /data/pin-$pin_version
  adb -e shell "cd /data/pin-$pin_version ; /data/busybox-i686 tar xzf android-install.tar.gz ; rm android-install.tar.gz"

  echo "****************************************"
  echo "****************************************"
  echo
  echo "Test Pin $pin_version on Android $api"
  echo
  adb -e shell "/data/pin-$pin_version/pin -version"
  echo
  echo
else
  echo "Cannot find pin-$pin_version-android/android-install.tar.gz !!!"
  echo "   Run \"tar czf android-install.tar.gz ia32 intel64 pin\" in ./pin-$pin_version-android/"
fi

echo "Close the emulator to continue..."
while [ ! `adb devices | grep device$ | wc -l` -eq 0 ]; do sleep 1; done

