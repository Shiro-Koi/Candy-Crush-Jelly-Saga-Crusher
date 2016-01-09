ARCHS = armv7 arm64
TARGET = iphone:clang:latest:latest
#CFLAGS = -fobjc-arc
#THEOS_PACKAGE_DIR_NAME = debs

include /var/theos/makefiles/common.mk

TWEAK_NAME = JellySagaCheats
JellySagaCheats_FILES = Tweak.xm
JellySagaCheats_FRAMEWORKS = UIKit
JellySagaCheats_LDFLAGS += -Wl,-segalign,4000

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += JellySagaCheats
include $(THEOS_MAKE_PATH)/aggregate.mk
