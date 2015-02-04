
echo "Android SDK (r24.0.2) for Linux"
wget http://dl.google.com/android/android-sdk_r24.0.2-linux.tgz
tar xzf android-sdk_r24.0.2-linux.tgz
echo "GUI config: Need to get Jelly Bean (4.2)"
./android-sdk-linux/tools/android sdk

alias android="`pwd`/android-sdk-linux/tools/android"
echo "Create an Android Virtual Device"
android create avd --name myavd --target android-17 --abi default/x86 --device 22

alias emulator="`pwd`/android-sdk-linux/tools/emulator64-x86"
echo "Launch the virtual device"
emulator -avd myavd &

echo "Latest BusyBox for i686"
wget http://www.busybox.net/downloads/binaries/latest/busybox-i686
echo "Pin 2.14 for Android NDK r10"
wget http://software.intel.com/sites/landingpage/pintool/downloads/pin-2.14-71313-gcc.4.9-android.tar.gz
tar xzf pin-2.14-71313-gcc.4.9-android.tar.gz

alias adb="`pwd`/android-sdk-linux/platform-tools/adb"
echo "Installing Pin on the device. BusyBox is used for the 'tar' utility."
adb shell mkdir /data/pin-android
adb push busybox-i686 /data/pin-android
adb push pin-2.14-71313-gcc.4.9-android/android-install.tar.gz /data/pin-android
adb shell "cd /data/pin-android ; chmod 775 busybox-i686 ; ./busybox-i686 tar xzf android-install.tar.gz ; rm busybox-i686 android-install.tar.gz"
adb shell "cd /data/pin-android ;  ./pin"
adb shell "cd /data/pin-android ; LD_LIBRARY_PATH=/data/pin-android/ia32/runtime:/data/pin-android/ia32/stl/:\$LD_LIBRARY_PATH"
adb shell "cd /data/pin-android ; BIN=/data/pin-android/ia32/bin:\$BIN LD_LIBRARY_PATH=/data/pin-android/ia32/runtime:/data/pin-android/ia32/stl/:\$LD_LIBRARY_PATH"

exit

echo "Android NDK (r10) for Linux"
wget http://dl.google.com/android/ndk/android-ndk-r10d-linux-x86_64.bin
chmod +x android-ndk-r10d-linux-x86_64.bin
./android-ndk-r10d-linux-x86_64.bin
echo "Build the toolchain"
./android-ndk-r10d/make-standalone-toolchain.sh --toolchain=x86-4.9 --platform=android-9 --install-dir=`pwd`/toolchain

#rm android-sdk_r24.0.2-linux.tgz android-ndk-r10d-linux-x86_64.bin busybox-i686 pin-2.14-71313-gcc.4.9-android.tar.gz

