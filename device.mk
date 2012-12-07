#
# Copyright 2012 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

ifeq ($(TARGET_PREBUILT_KERNEL),)
  LOCAL_KERNEL := device/sony/lt26/kernel
else
  LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

PRODUCT_COPY_FILES += \
    $(LOCAL_KERNEL):kernel

PRODUCT_PACKAGES := \
    lights.lt26 \
    e2fsck

PRODUCT_CHARACTERISTICS := nosdcard

DEVICE_PACKAGE_OVERLAYS += device/sony/lt26/overlay

# The gps config appropriate for this device
$(call inherit-product, device/common/gps/gps_eu_supl.mk)

# These are the hardware-specific features
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.distinct.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.distinct.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.distinct.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml

# This device is xhdpi.  However the platform doesn't
# currently contain all of the bitmaps at xhdpi density so
# we do this little trick to fall back to the hdpi version
# if the xhdpi doesn't exist.
PRODUCT_AAPT_CONFIG := normal hdpi xhdpi
PRODUCT_AAPT_PREF_CONFIG := xhdpi


# Configuration scripts
PRODUCT_COPY_FILES += \
   $(LOCAL_PATH)/recovery.fstab:root/recovery.fstab \
   $(LOCAL_PATH)/config/fstab.lt26:root/fstab.lt26 \
   $(LOCAL_PATH)/config/vold.fstab:system/etc/vold.fstab \
   $(LOCAL_PATH)/prebuilt/hw_config.sh:system/etc/hw_config.sh

# Common Qualcomm scripts
PRODUCT_COPY_FILES += \
    device/sony/lt26/config/init.qcom.efs.sync.sh:system/etc/init.qcom.efs.sync.sh

# Custom init / uevent
PRODUCT_COPY_FILES += \
    device/sony/lt26/config/init.semc.rc:root/init.semc.rc \
    device/sony/lt26/config/ueventd.semc.rc:root/ueventd.semc.rc

# USB function switching
PRODUCT_COPY_FILES += \
   $(LOCAL_PATH)/config/init.semc.usb.rc:root/init.semc.usb.rc

# Key layouts and touchscreen
PRODUCT_COPY_FILES += \
   $(LOCAL_PATH)/config/atdaemon.kl:system/usr/keylayout/atdaemon.kl \
   $(LOCAL_PATH)/config/clearpad.kl:system/usr/keylayout/clearpad.kl \
   $(LOCAL_PATH)/config/clearpad.idc:system/usr/idc/clearpad.idc \
   $(LOCAL_PATH)/config/fuji-keypad.kl:system/usr/keylayout/fuji-keypad.kl \
   $(LOCAL_PATH)/config/gpio-key.kl:system/usr/keylayout/gpio-key.kl \
   $(LOCAL_PATH)/config/keypad-pmic-fuji.kl:system/usr/keylayout/keypad-pmic-fuji.kl \
   $(LOCAL_PATH)/config/pmic8058_pwrkey.kl:system/usr/keylayout/pmic8058_pwrkey.kl \
   $(LOCAL_PATH)/config/simple_remote.kl:system/usr/keylayout/simple_remote.kl

$(call inherit-product, frameworks/native/build/phone-xhdpi-1024-dalvik-heap.mk)

$(call inherit-product-if-exists, vendor/sony/lt26/lt26-vendor.mk)

# Wifi
BOARD_WLAN_DEVICE_REV := bcm4330_b2
WIFI_BAND             := 802_11_ABG
$(call inherit-product-if-exists, hardware/broadcom/wlan/bcmdhd/firmware/bcm4330/device-bcm.mk)

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/config/calibration:system/etc/wifi/calibration

