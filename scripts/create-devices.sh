
for api in $ANDROID_PIN_APIS
do
  if [ `android list avd | grep "Name: device-$api" | wc -l` -eq 0 ]
  then
    android create avd --name device-$api --target android-$api --abi default/x86 --device 22
  fi
done

