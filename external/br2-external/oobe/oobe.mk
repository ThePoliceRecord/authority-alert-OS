################################################################################
#
# oobe (Out-of-Box Experience)
#
################################################################################

OOBE_VERSION = development
OOBE_SITE = https://github.com/ThePoliceRecord/sscma-example-sg200x
OOBE_SITE_METHOD = git
OOBE_GIT_SUBMODULES = YES
OOBE_LICENSE = Apache-2.0

# Build step: compile the package using the Makefile
define OOBE_BUILD_CMDS
	$(MAKE) -C $(@D)/solutions/oobe \
		CC="$(TARGET_CC)" \
		CXX="$(TARGET_CXX)" \
		CFLAGS="$(TARGET_CFLAGS) -I$(@D)/components/sophgo/video/include -I$(STAGING_DIR)/usr/include" \
		CXXFLAGS="$(TARGET_CXXFLAGS) -I$(@D)/components/sophgo/video/include -I$(STAGING_DIR)/usr/include" \
		LDFLAGS="$(TARGET_LDFLAGS) -L$(STAGING_DIR)/usr/lib" \
		VIDEO_DIR="$(@D)/components/sophgo/video" \
		BUILD_DIR="build"
endef

# Install step: copy the built binary and rootfs files to the target directory
define OOBE_INSTALL_TARGET_CMDS
	# Install the executable file if it exists
	if [ -f $(@D)/solutions/oobe/build/oobe ]; then \
		$(INSTALL) -D -m 0755 $(@D)/solutions/oobe/build/oobe \
			$(TARGET_DIR)/usr/local/bin/oobe; \
	fi
	
	# Copy rootfs files if they exist
	if [ -d $(@D)/solutions/oobe/rootfs ]; then \
		cp -r $(@D)/solutions/oobe/rootfs/* $(TARGET_DIR)/; \
	fi
	
	# Copy web assets if they exist
	if [ -d $(@D)/solutions/oobe/web ]; then \
		mkdir -p $(TARGET_DIR)/usr/share/oobe/www; \
		cp -r $(@D)/solutions/oobe/web/* $(TARGET_DIR)/usr/share/oobe/www/; \
	fi
endef

$(eval $(generic-package))
