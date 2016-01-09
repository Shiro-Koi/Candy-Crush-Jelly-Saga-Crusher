ARCHS = armv7 arm64
include /var/theos/makefiles/common.mk

BUNDLE_NAME = JellySagaCheats
JellySagaCheats_FILES = JellySagaCheats.mm
JellySagaCheats_INSTALL_PATH = /Library/PreferenceBundles
JellySagaCheats_FRAMEWORKS = UIKit
JellySagaCheats_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/JellySagaCheats.plist$(ECHO_END)
