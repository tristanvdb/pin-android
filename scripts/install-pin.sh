
#
# Usage: install-pin.sh

if [ ! `adb devices | grep device$ | wc -l` -eq 0 ]
then
  echo "Close all running emulator to start..."
  while [ ! `adb devices | grep device$ | wc -l` -eq 0 ]; do sleep 1; done
  echo
  echo
fi

for api in $ANDROID_PIN_APIS
do
  echo
  echo "*** Launch emulator for API $api ***"
  echo
  emulator -avd device-$api &
  while [ `adb devices | grep device$ | wc -l` -eq 0 ]; do sleep 1; done
  echo

  $(ANDROID_PIN_PATH)/scripts/install-pin-on-device.sh

  echo "Close the emulator to continue..."
  while [ ! `adb devices | grep device$ | wc -l` -eq 0 ]; do sleep 1; done
  echo
  echo
done

