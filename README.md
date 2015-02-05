
## Usage

```bash
git clone git@github.com:tristanvdb/pin-android.git
cd pin-android

# Downloads: * Android SDK
#            * Pin 2.13 (r65163, NDK9),
#            *     2.14 (r67254, NDK9),
#            *     2.14 (r71313, NDK9 & NDK10)
#            * BusyBox
# Creates:   * android-pin.rc
./install.sh
source android-pin.rc

# GUI interface to download different Android SDKs
# I downloaded:   * 4.2.2 (API 17)
#                 * 4.3.1 (API 18)
#                 * 4.4.2 (API 19)
#                 * 5.0.1 (API 21)
android sdk

# Create a device for 4.2.2 (API 17)
./create-device.sh 17

# Create a device for 4.3.1 (API 18)
./create-device.sh 18

# Create a device for 4.4.2 (API 19)
./create-device.sh 19

# Create a device for 5.0.1 (API 21)
./create-device.sh 21

./install-pin.sh 17 2.13-65163-gcc.4.6 # ok
./install-pin.sh 17 2.14-67254-gcc.4.6 # ok
./install-pin.sh 17 2.14-71313-gcc.4.6 # ok
./install-pin.sh 17 2.14-71313-gcc.4.9 # soinfo_relocate(linker.cpp:975): cannot locate symbol "stpcpy" referenced by "/data/pin-2.14-71313-gcc.4.9/pin"...CANNOT LINK EXECUTABLE

./install-pin.sh 18 2.13-65163-gcc.4.6 # ok
./install-pin.sh 18 2.14-67254-gcc.4.6 # ok
./install-pin.sh 18 2.14-71313-gcc.4.6 # ok
./install-pin.sh 18 2.14-71313-gcc.4.9 # CANNOT LINK EXECUTABLE: cannot locate symbol "stpcpy" referenced by "/data/pin-2.14-71313-gcc.4.9/pin"...

./install-pin.sh 19 2.13-65163-gcc.4.6 # ok
./install-pin.sh 19 2.14-67254-gcc.4.6 # ok
./install-pin.sh 19 2.14-71313-gcc.4.6 # ok
./install-pin.sh 19 2.14-71313-gcc.4.9 # CANNOT LINK EXECUTABLE: cannot locate symbol "stpcpy" referenced by "/data/pin-2.14-71313-gcc.4.9/pin"...

./install-pin.sh 21 2.13-65163-gcc.4.6 # error: only position independent executables (PIE) are supported.
./install-pin.sh 21 2.14-67254-gcc.4.6 # WARNING: linker: /data/pin-2.14-67254-gcc.4.6/pin has text relocations. This is wasting memory and prevents security hardening. Please fix.
                                       # WARNING: linker: /data/pin-2.14-67254-gcc.4.6/ia32/bin/pinbin has text relocations. This is wasting memory and prevents security hardening. Please fix.
                                       # Aborted
./install-pin.sh 21 2.14-71313-gcc.4.6 # WARNING: linker: /data/pin-2.14-71313-gcc.4.6/pin has text relocations. This is wasting memory and prevents security hardening. Please fix.
                                       # WARNING: linker: /data/pin-2.14-71313-gcc.4.6/ia32/bin/pinbin has text relocations. This is wasting memory and prevents security hardening. Please fix.
                                       # Aborted
./install-pin.sh 21 2.14-71313-gcc.4.9 # Aborted
```

## Docs

[Jelly Bean Emulator](https://software.intel.com/en-us/android/articles/intel-atom-x86-image-for-android-4-2-jelly-bean-installation-instructions-recommended)

[Busybox](http://stackoverflow.com/questions/5336154/pushing-busybox-into-android-emulator)

[PIN](https://software.intel.com/sites/default/files/article/256671/pindroid-tutorial-01_1.pdf)

## To reproduce

### Download and Path

```bash
export PATH="`pwd`/android-sdk-linux/tools/":$PATH
export PATH="`pwd`/android-sdk-linux/platform-tools/":$PATH

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
```

### Android SDK

```bash
# Android 4.2.2, 4.3.1, 4.4.2, 4.4W.2, 5.0.1
ANDROID_VERSION=17 18 19 20 21

# GUI config
android sdk

# Create Android Virtual Devices for each Android API
for api in $ANDROID_VERSION
do
  android create avd --name device-$api --target android-$api --abi default/x86 --device 22
done
```

### PIN

```bash
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
```

### Android NDK

I haven't reached this part.

```bash
# Android NDK (r10) for Linux
wget http://dl.google.com/android/ndk/android-ndk-r10d-linux-x86_64.bin
chmod +x android-ndk-r10d-linux-x86_64.bin
./android-ndk-r10d-linux-x86_64.bin
# Build the toolchain
./android-ndk-r10d/make-standalone-toolchain.sh --toolchain=x86-4.9 --platform=android-9 --install-dir=`pwd`/toolchain
```

