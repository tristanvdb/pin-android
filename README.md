
## Archive

[Android SDK](http://dl.google.com/android/android-sdk_r24.0.2-linux.tgz)

[Android NDK](http://dl.google.com/android/ndk/android-ndk-r10d-linux-x86_64.bin)

[Pin 2.12 (rev 56759) for GCC 4.4.3 and Android](http://software.intel.com/sites/landingpage/pintool/downloads/pin-2.14-71313-gcc.4.9-android.tar.gz)

[BusyBox](http://www.busybox.net/downloads/binaries/latest/busybox-i686)

## Docs

[Jelly Bean Emulator](https://software.intel.com/en-us/android/articles/intel-atom-x86-image-for-android-4-2-jelly-bean-installation-instructions-recommended)

[Busybox](http://stackoverflow.com/questions/5336154/pushing-busybox-into-android-emulator)

[PIN](https://software.intel.com/sites/default/files/article/256671/pindroid-tutorial-01_1.pdf)

## To reproduce

```bash
# Android SDK (r24.0.2) for Linux
wget http://dl.google.com/android/android-sdk_r24.0.2-linux.tgz
tar xzf android-sdk_r24.0.2-linux.tgz
# GUI config: Need to get Jelly Bean (4.2)
./android-sdk-linux/tools/android sdk

alias android="`pwd`/android-sdk-linux/tools/android"
# Create an Android Virtual Device
android create avd --name myavd --target android-17 --abi default/x86 --device 22

alias emulator="`pwd`/android-sdk-linux/tools/emulator64-x86"
# Launch the virtual device
emulator -avd myavd &

# Latest BusyBox for i686
wget http://www.busybox.net/downloads/binaries/latest/busybox-i686
# Pin 2.14 for Android NDK r10
wget http://software.intel.com/sites/landingpage/pintool/downloads/pin-2.14-71313-gcc.4.9-android.tar.gz
tar xzf pin-2.14-71313-gcc.4.9-android.tar.gz

alias adb="`pwd`/android-sdk-linux/platform-tools/adb"
# Installing Pin on the device. BusyBox is used for the 'tar' utility.
adb shell mkdir /data/pin-android
adb push busybox-i686 /data/pin-android
adb push pin-2.14-71313-gcc.4.9-android/android-install.tar.gz /data/pin-android
adb shell
# > cd /data/pin-android
# > chmod 775 busybox-i686
# > ./busybox-i686 tar xzf android-install.tar.gz
# > ./pin
# $ soinfo_relocate(linker.cpp:975): cannot locate symbol "stpcpy" referenced by "./pin"...CANNOT LINK EXECUTABLE
# > LD_LIBRARY_PATH=/data/pin-android/ia32/runtime:/data/pin-android/ia32/stl/:$LD_LIBRARY_PATH
# $ soinfo_link_image(linker.cpp:1635): could not load library "libc.so" needed by "./pin"; caused by soinfo_relocate(linker.cpp:975): cannot locate symbol "linker_get_tls" referenced by "libc.so"...CANNOT LINK EXECUTABLE

# Android NDK (r10) for Linux
wget http://dl.google.com/android/ndk/android-ndk-r10d-linux-x86_64.bin
chmod +x android-ndk-r10d-linux-x86_64.bin
./android-ndk-r10d-linux-x86_64.bin
# Build the toolchain
./android-ndk-r10d/make-standalone-toolchain.sh --toolchain=x86-4.9 --platform=android-9 --install-dir=`pwd`/toolchain
```

