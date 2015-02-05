
### Path

export PATH="`pwd`/android-sdk-linux/tools/":$PATH
export PATH="`pwd`/android-sdk-linux/platform-tools/":$PATH

### Download

# Latest BusyBox for i686
wget http://www.busybox.net/downloads/binaries/latest/busybox-i686

# Android SDK (r24.0.2) for Linux
wget http://dl.google.com/android/android-sdk_r24.0.2-linux.tgz
tar xzf android-sdk_r24.0.2-linux.tgz

# Pin 2.13 (r65163) for Android NDK9
# Pin 2.14 (r67254) for Android NDK9
# Pin 2.14 (r71313) for Android NDK9 & NDK10
export PIN_VERSIONS= \
  2.13-65163-gcc.4.6 \
  2.14-67254-gcc.4.6 \
  2.14-71313-gcc.4.6 \
  2.14-71313-gcc.4.9
for pin_version in $PIN_VERSION
do
  wget http://software.intel.com/sites/landingpage/pintool/downloads/pin-$pin_version.tar.gz
  tar xzf pin-$pin_version.tar.gz
done

### Android SDK

# Android 4.2.2, 4.3.1, 4.4.2, 4.4W.2, 5.0.1
ANDROID_VERSION=17 18 19 20 21

# GUI config
android sdk

# Create Android Virtual Devices for each Android API
for api in $ANDROID_VERSION
do
  android create avd --name device-$api --target android-$api --abi default/x86 --device 22
done


### PIN

for api in $ANDROID_VERSION
do
  # Launch the virtual device
  emulator -avd device-$api &

  # Install busybox, used for its 'tar' utility.
  adb push busybox-i686 /system/bin/
  adb shell "chmod 775 /system/bin/busybox-i686"

  # Install the different version of Pin
  for pin_version in $PIN_VERSION
  do
    adb shell mkdir /data/pin-$pin_version
    adb push pin-$pin_version-android/android-install.tar.gz /data/pin-$pin_version
    adb shell "cd /data/pin-$pin_version ; busybox-i686 tar xzf android-install.tar.gz ; rm android-install.tar.gz"
  done

  # Test the different version of Pin
  for pin_version in $PIN_VERSION
  do
    echo "Test Pin $pin_version on Android $api"
    adb shell "/data/pin-$pin_version/pin -version"
    adb shell "/data/pin-$pin_version/pin -- /system/bin/ls"
  done

  read -p "Close the emulator then press any key to continue..."
done

