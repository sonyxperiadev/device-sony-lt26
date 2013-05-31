Copyright (C) Sony Mobile Communication 2012
============================================

This is the Android device configuration for Xperia S.

To setup a tree and build images for the device do the following:

repo init as described by Google over at:
http://source.android.com/source/downloading.html

Put the following snippet in .repo/local_manifests/lt26.xml
<?xml version="1.0" encoding="UTF-8"?>
<manifest>
  <remote  name="sony" fetch="git://github.com/sonyxperiadev/" />
  <project path="device/sony/lt26" name="device-sony-lt26" remote="sony" revision="master" />
  <project path="vendor/sony/dash" name="DASH.git" groups="device" revision="master" remote="sony" />
  <remove-project name="platform/hardware/invensense" />
</manifest>

Download the zip file with vendor binaries from:
http://developer.sonymobile.com/downloads/tool/software-binaries-for-xperia-s/

In the root of your Android code tree unzip the SW_binaries_for_Xperia_S_v1.tar.zip,
you should now have a directory named vendor/sony/lt26 in your tree.

Unfortunately the vendor binaries needs a couple of patches to be compatible with
AOSP. Apply the patches by running the apply_patch tool in the root of you Android code
tree.

repo sync
./device/sony/lt26/apply_patches
lunch full_lt26-userdebug
make

To flash the images produced make sure your device is unlocked, as described on
http://unlockbootloader.sonymobile.com/

Enter fastboot mode on the device by pressing volume up while inserting the USB
cable or execute adb reboot bootloader.

fastboot flash userdata out/target/product/lt26/userdata.img
fastboot flashall

Reflashing userdata is not necessary every time, but incompatibilities with
previous content might result in a device that doesn't boot. If this happens
try to reflash just the userdata again.
