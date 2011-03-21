include theos/makefiles/common.mk

TWEAK_NAME = Widge
Widge_FILES = Tweak.xm
SUBPROJECTS = framework

include $(FW_MAKEDIR)/tweak.mk
Widge_FRAMEWORKS = UIKit Foundation
