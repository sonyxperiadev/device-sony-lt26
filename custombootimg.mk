LOCAL_PATH := $(call my-dir)

MKELF := device/sony/lt26/tools/mkelf.py
INSTALLED_BOOTIMAGE_TARGET := $(PRODUCT_OUT)/boot.img
$(INSTALLED_BOOTIMAGE_TARGET): $(PRODUCT_OUT)/kernel $(INSTALLED_RAMDISK_TARGET) $(MKBOOTIMG) $(MINIGZIP) $(INTERNAL_BOOTIMAGE_FILES)
	$(call pretty,"Boot image: $@")
	$(hide) python $(MKELF) -o $@ $(PRODUCT_OUT)/kernel@0x40208000 $(PRODUCT_OUT)/ramdisk.img@0x41300000,ramdisk vendor/sony/lt26/proprietary/boot/RPM.bin@0x20000,rpm

INSTALLED_RECOVERYIMAGE_TARGET := $(PRODUCT_OUT)/recovery.img
$(INSTALLED_RECOVERYIMAGE_TARGET): $(MKBOOTIMG) $(recovery_ramdisk) $(recovery_kernel)
	$(call pretty,"Recovery image: $@")
	$(hide) python $(MKELF) -o $@ $(PRODUCT_OUT)/kernel@0x40208000 $(PRODUCT_OUT)/ramdisk-recovery.img@0x41300000,ramdisk vendor/sony/lt26/proprietary/boot/RPM.bin@0x20000,rpm
#	$(hide) $(call assert-max-image-size,$@,$(BOARD_RECOVERYIMAGE_PARTITION_SIZE),raw)
