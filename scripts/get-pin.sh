
# Get Pin:
#  2.13 (r65163, NDK9)  : 2.13-65163-gcc.4.6
#  2.14 (r67254, NDK9)  : 2.14-67254-gcc.4.6
#  2.14 (r71313, NDK9)  : 2.14-71313-gcc.4.6
#  2.14 (r71313, NDK10) : 2.14-71313-gcc.4.9

mkdir -p pin

pushd $ANDROID_PIN_PATH/pin

for pin_version in $ANDROID_PIN_VERSIONS
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
  pushd pin-2.14-71313-gcc.4.6-android
  if [ ! -e android-install.tar.gz ]
  then
    tar czf android-install.tar.gz ia32 intel64 pin
  fi
  popd
fi

popd

