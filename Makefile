include theos/makefiles/common.mk

TWEAK_NAME = Widge
Widge_FILES = Tweak.xm WGRootController.m
SUBPROJECTS = framework demowidget

include $(FW_MAKEDIR)/tweak.mk
Widge_FRAMEWORKS = UIKit Foundation
