
> android-pin.rc
echo >> android-pin.rc
echo "export PATH=`pwd`/android-sdk-linux/tools/:\$PATH" >> android-pin.rc
echo "export PATH=`pwd`/android-sdk-linux/platform-tools/:\$PATH" >> android-pin.rc
echo >> android-pin.rc
echo "export PIN_VERSION=\"2.13-65163-gcc.4.6 2.14-67254-gcc.4.6 2.14-71313-gcc.4.6 2.14-71313-gcc.4.9\"" >> android-pin.rc
echo "export ANDROID_VERSION=\"17 18 19 21\"" >> android-pin.rc
echo >> android-pin.rc
source android-pin.rc

### Latest BusyBox for i686

if [ ! -e busybox-i686 ]
then
  wget http://www.busybox.net/downloads/binaries/latest/busybox-i686
fi

# Pin 2.13 (r65163, NDK9), 2.14 (r67254, NDK9), and 2.14 (r71313, NDK9 & NDK10)

for pin_version in $PIN_VERSION
do
  if [ ! -e pin-$pin_version-android ]
  then
    wget http://software.intel.com/sites/landingpage/pintool/downloads/pin-$pin_version-android.tar.gz
    tar xzf pin-$pin_version-android.tar.gz
    rm pin-$pin_version-android.tar.gz
  fi
done

if [ -e pin-2.14-71313-gcc.4.6-android ]
then
  cd pin-2.14-71313-gcc.4.6-android
  tar czf android-install.tar.gz ia32 intel64 pin
  cd ..
fi

# Android SDK (r24.0.2) for Linux

if [ ! -e android-sdk-linux ]
then
  wget http://dl.google.com/android/android-sdk_r24.0.2-linux.tgz
  tar xzf android-sdk_r24.0.2-linux.tgz
  rm android-sdk_r24.0.2-linux.tgz
fi

