ifneq ($(filter lt26,$(TARGET_DEVICE)),)

LOCAL_PATH := $(call my-dir)

ELF_BOOTIMAGE := $(PRODUCT_OUT)/boot.img.elf

droid: $(ELF_BOOTIMAGE)

$(ELF_BOOTIMAGE): $(PRODUCT_OUT)/boot.img
	$(call pretty,"ELF Boot image: $(ELF_BOOTIMAGE)")
	$(hide) python device/sony/lt26/tools/mkelf.py -o $(ELF_BOOTIMAGE) $(PRODUCT_OUT)/kernel@0x40208000 $(PRODUCT_OUT)/ramdisk.img@0x41300000,ramdisk vendor/sony/lt26/proprietary/boot/RPM.bin@0x20000,rpm
	$(hide) cp -p $(ELF_BOOTIMAGE) $(PRODUCT_OUT)/boot.img

endif

include $(call all-makefiles-under,$(LOCAL_PATH))
