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
    lights.lt26

DEVICE_PACKAGE_OVERLAYS += device/sony/lt26/overlay

# The gps config appropriate for this device
$(call inherit-product, device/common/gps/gps_eu_supl.mk)

# These are the hardware-specific features
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml

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

# EGL config
PRODUCT_COPY_FILES += \
    device/sony/lt26/config/egl.cfg:system/lib/egl/egl.cfg

# Common Qualcomm scripts
PRODUCT_COPY_FILES += \
    device/sony/lt26/config/init.qcom.efs.sync.sh:system/etc/init.qcom.efs.sync.sh

# Custom init / uevent
PRODUCT_COPY_FILES += \
    device/sony/lt26/config/init.lt26.rc:root/init.lt26.rc \
    device/sony/lt26/config/ueventd.lt26.rc:root/ueventd.lt26.rc

# USB function switching
PRODUCT_COPY_FILES += \
   $(LOCAL_PATH)/config/init.lt26.usb.rc:root/init.lt26.usb.rc

$(call inherit-product, frameworks/native/build/phone-xhdpi-1024-dalvik-heap.mk)

$(call inherit-product-if-exists, vendor/sony/lt26/lt26-vendor.mk)

# Wifi
BOARD_WLAN_DEVICE_REV := bcm4330_b2
WIFI_BAND             := 802_11_ABG
$(call inherit-product-if-exists, hardware/broadcom/wlan/bcmdhd/firmware/bcm4330/device-bcm.mk)
