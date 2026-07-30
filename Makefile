export THEOS_DEVICE_IP = localhost
ARCHS = arm64
TARGET = iphone:clang:14.5:12.0
INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Exemplo
Exemplo_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk
