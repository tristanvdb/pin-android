
## Usage

```bash
git clone git@github.com:tristanvdb/pin-android.git
cd pin-android

# Default configuration:
#      export ANDROID_PIN_PATH=`pwd`
#      export ANDROID_PIN_VERSIONS=2.14-71313-gcc.4.6 # Pin 2.14 (r71313, NDK9)
#      export ANDROID_PIN_APIS=19

# Downloads: * Android SDK
#            * Requested Pin
#            * BusyBox
# Creates:   * android-pin.rc
./scripts/install.sh
source scripts/android-pin.rc

# GUI interface to download different Android SDKs:
#      I recommend to install Android 4.4.2 (API 19)
#      By default Android 5.0.1 (API 21) will be installed (I don't use it).
android sdk

# Create one devices by selected API [Android 4.4.2 (API 19)]
./scripts/create-devices.sh

# Install selected versions of Pin on each device [Android 4.4.2 (API 19), Pin 2.14 (r71313, NDK9)]
./scripts/install-pin.sh

# Test all installation of Pin  [Android 4.4.2 (API 19), Pin 2.14 (r71313, NDK9)]
./scripts/test-pin.sh
```

Other versions that can be selected:
 * Android
  * 4.2.2 (API 17)
  * 4.3.1 (API 18)
  * 4.4.2 (API 19)
  * 5.0.1 (API 21)
 * Pin
  * Android NDK 9
    * 2.13 (r65163) : 2.14-65163-gcc.4.6
    * 2.13 (r67254) : 2.14-67254-gcc.4.6
    * 2.14 (r71313) : 2.14-71313-gcc.4.6
  * Android NDK 10
    * 2.14 (r71313) : 2.14-71313-gcc.4.9

To work with an installed version:
```bash
cd pin-android
source scripts/android-pin.rc

# Start the emulator on the device for 4.4.2 (API 19)
emulator -avd device-19 &

# To check the emulator status (offline or device)
adb devices

# Test Pin 2.14 (r71313) for NDK9
adb shell "/data/pin-2.14-71313-gcc.4.6/pin -- /system/bin/ls"
```

## Docs

[Jelly Bean Emulator](https://software.intel.com/en-us/android/articles/intel-atom-x86-image-for-android-4-2-jelly-bean-installation-instructions-recommended)

[Busybox](http://stackoverflow.com/questions/5336154/pushing-busybox-into-android-emulator)

[PIN](https://software.intel.com/sites/default/files/article/256671/pindroid-tutorial-01_1.pdf)

## TODO

### Android NDK

```bash
# Android NDK (r10) for Linux
wget http://dl.google.com/android/ndk/android-ndk-r10d-linux-x86_64.bin
chmod +x android-ndk-r10d-linux-x86_64.bin
./android-ndk-r10d-linux-x86_64.bin
# Build the toolchain
./android-ndk-r10d/make-standalone-toolchain.sh --toolchain=x86-4.9 --platform=android-9 --install-dir=`pwd`/toolchain
```

### Cross compile Pin Tool



### Link Pin Tool to App



