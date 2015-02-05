
if [ -e android-pin.rc ]
then
  source android-pin.rc
else
  echo "Ressource file android-pin.rc is missing..."
  exit
fi

if [ `android list avd | grep "Name: device-$api" | wc -l` -eq 0 ]
then
  echo "Create device for api $1"
  android create avd --name device-$api --target android-$api --abi default/x86 --device 22
else
  echo "API $1 already has an associated device."
fi

