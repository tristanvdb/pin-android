
#
# Usage: test-pin.sh

for version in $ANDROID_PIN_VERSION
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

