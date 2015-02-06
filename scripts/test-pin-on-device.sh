
#
# Usage: test-pin.sh
#
#    Expect 1 emulator running with PIN installed (all version in $ANDROID_PIN_VERSION)
#

for version in $ANDROID_PIN_VERSIONS
do
  echo "****************************************"
  echo "****************************************"
  echo
  echo "Test Pin $version on Android $api"
  echo
  adb -e shell "/data/pin-$version/pin -version"
  echo
  echo
done

