
# Android SDK (r24.0.2) for Linux

if [ ! -e $ANDROID_PIN_PATH/sdk ]
then
  pushd $ANDROID_PIN_PATH
  wget http://dl.google.com/android/android-sdk_r24.0.2-linux.tgz
  tar xzf android-sdk_r24.0.2-linux.tgz
  rm android-sdk_r24.0.2-linux.tgz
  mv android-sdk-linux sdk
  popd
fi

