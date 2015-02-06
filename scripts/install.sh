
if [ -z $ANDROID_PIN_PATH ] ; then
  export ANDROID_PIN_PATH=`pwd`
elif [ ! -d $ANDROID_PIN_PATH ] ; then
  echo "[ERROR] ANDROID_PIN_PATH=$ANDROID_PIN_PATH not a valid directory."
  exit
fi

if [ -z $ANDROID_PIN_VERSIONS ] ; then
  export ANDROID_PIN_VERSIONS=2.14-71313-gcc.4.6 # 2.14 (r71313, NDK9)
fi

if [ -z $ANDROID_PIN_APIS ] ; then
  export ANDROID_PIN_APIS=19 # 4.4.2
fi

> $ANDROID_PIN_PATH/scripts/android-pin.rc
echo >> $ANDROID_PIN_PATH/scripts/android-pin.rc
echo "export ANDROID_PIN_PATH=$ANDROID_PIN_PATH"         >> $ANDROID_PIN_PATH/scripts/android-pin.rc
echo "export ANDROID_PIN_VERSIONS=$ANDROID_PIN_VERSIONS" >> $ANDROID_PIN_PATH/scripts/android-pin.rc
echo "export ANDROID_PIN_APIS=$ANDROID_PIN_APIS"         >> $ANDROID_PIN_PATH/scripts/android-pin.rc
echo >> $ANDROID_PIN_PATH/scripts/android-pin.rc
echo "export PATH=$ANDROID_PIN_PATH/sdk/tools/:\$PATH"          >> $ANDROID_PIN_PATH/scripts/android-pin.rc
echo "export PATH=$ANDROID_PIN_PATH/sdk/platform-tools/:\$PATH" >> $ANDROID_PIN_PATH/scripts/android-pin.rc
echo >> $ANDROID_PIN_PATH/scripts/android-pin.rc

source $ANDROID_PIN_PATH/scripts/android-pin.rc

$ANDROID_PIN_PATH/scripts/get-busybox.sh
$ANDROID_PIN_PATH/scripts/get-pin.sh
$ANDROID_PIN_PATH/scripts/get-android-sdk.sh

