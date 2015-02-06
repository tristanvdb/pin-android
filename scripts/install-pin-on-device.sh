
#
# Usage: install-pin-on-device.sh
#
#    Expect 1 emulator running
#

# Install busybox, used for its 'tar' utility.
adb -e shell mkdir -p /data/tools/
adb -e push $ANDROID_PIN_PATH/busybox-i686 /data/tools/
adb -e shell "chmod 775 /data/tools/busybox-i686"

for version in $ANDROID_PIN_VERSIONS
do
  if [ -e pin/pin-$version-android/android-install.tar.gz ]
  then
    adb -e shell rm -rf /data/pin-$version
    adb -e shell mkdir -p /data/pin-$version
    adb -e push $ANDROID_PIN_PATH/pin/pin-$version-android/android-install.tar.gz /data/pin-$version
    adb -e shell "cd /data/pin-$version ; /data/tools/busybox-i686 tar xzvf android-install.tar.gz ; rm android-install.tar.gz"
  else
    echo "Cannot find pin-$version-android/android-install.tar.gz !!!"
  fi
done

