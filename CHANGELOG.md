## 0.2.3 (2025-12-27)

### sg2002_recamera_emmc

- **New Features:**
    
    - **Camera Streaming Support**
      - Added sscma-camera-streamer package for video streaming functionality
      - Integrated with SSCMA supervisor for camera stream management
      - Provides real-time video streaming capabilities for remote monitoring
      - Configuration updates in br2-external packages

- **Configuration Changes:**
    - Updated [`Config.in`](reCamera-OS/external/br2-external/Config.in) to include camera-streamer package
    - Modified [`sscma-supervisor.mk`](reCamera-OS/external/br2-external/sscma-supervisor/sscma-supervisor.mk) for camera streaming integration
    - Added complete [`sscma-camera-streamer`](reCamera-OS/external/br2-external/sscma-camera-streamer/sscma-camera-streamer.mk) package definition

- **Statistics:**
    - **Total Changes:** 4 files changed
    - **Additions:** +50 lines
    - **Deletions:** -1 line
    - **Net:** +49 lines

## 0.2.2 (2025-12-27)

### sg2002_recamera_emmc

- **New Features:**
    
    - **OTA Security Enhancement (Breaking Change)**
      - Migrated from MD5 to SHA256 hash verification
      - **Server Changes:**
        - `build.sh`: Generate `sha256sum.txt` instead of `md5sum.txt` in OTA artifacts
        - `ota_server/prepare_release.sh`: Create `sg2002_recamera_emmc_sha256sum.txt` manifests
        - `.gitlab-ci.yml`: Package stage generates SHA256 checksums
      - **Client Changes:**
        - `upgrade.sh`: Complete rewrite with SHA256-only verification (177 line changes)
        - Automatic hash algorithm detection for safer upgrades
        - Removed all MD5 fallback logic
      - **Security:** SHA256 provides 256-bit cryptographic security vs MD5's broken 128-bit
    
    - **Filesystem Support**
      - Added full exFAT support (`BR2_PACKAGE_EXFATPROGS=y`)
      - Tools: mkfs.exfat, fsck.exfat, exfatlabel
      - Enables formatting/checking exFAT on external media
    
    - **Build System Overhaul**
      - **Buildroot Package Updates:**
        - **Networking:** Added c-ares 1.32.3 (CVE fixes), openssh 9.9p1, dropbear 2024.86
        - **System:** Added coreutils 9.5, util-linux 2.40.2, expat 2.6.4
        - **Kernel:** Added kmod 33 with musl/Python 3.13 compatibility
        - **Security:** Added hostapd 2.11, libgpg-error 1.51, libopenssl 3.3.2
        - **Python:** Upgraded to Python 3.13.1 with full packaging infrastructure
          - python-flit-core, python-installer, python-pypa-build
          - python-pyproject-hooks, python-setuptools, python-wheel
          - python-pip, python-py, python-packaging
          - python-bcrypt, python-passlib for authentication
        - **Gettext:** Added gettext-gnu 0.22.5 / gettext-tiny 0.3.2 with GETTEXTIZE fix
        - **Build Tools:** Updated autoconf 2.72, automake 1.17
        - **Busybox:** Updated with kernel 6.8+ support + security patches (CVE-2023-42366)
        - **WebSockets:** Added libwebsockets 4.3.3
        - **Networking:** Added zerotier-one 1.14.2 for VPN support
      
      - **Downgraded Packages:**
        - libuv: 1.51.0 → 1.44.2 (fixes pthread_getname_np musl incompatibility)
      
      - **Removed Packages:**
        - Removed nodejs package (cross-compilation issues on musl/RISC-V)
        - Removed sscma-node (nodejs dependency conflicts)
      
      - **Docker Build:**
        - Enhanced `.devcontainer/Dockerfile` with 7 new lines
        - Improved `docker_build.sh` script
        - Added `external/setenv.sh` for environment setup
      
      - **Linux Kernel:**
        - Updated `cvitek_sg2002_recamera_emmc_defconfig` (5 line changes)
        - Maintained exFAT driver support (CONFIG_EXFAT_FS=y)

- **Breaking Changes:**
    
    - **OTA Incompatibility**
      - Devices with firmware < 0.2.2 cannot OTA update from 0.2.2+ servers
      - Manifest filename changed: `*_md5sum.txt` → `*_sha256sum.txt`
      - No MD5 backward compatibility - enhanced security priority
      - **Migration Required:** Manual flash for devices < 0.2.2
    
    - **Removed Software**
      - Node.js and sscma-node no longer included
      - Applications depending on Node.js must be refactored

- **Configuration Changes:**
    - **Buildroot defconfig** (`cvitek_CV181X_musl_riscv64_defconfig`): 38 modified lines
      - Enabled/disabled packages per above lists
      - Updated package versions and dependencies
      - Configured new build infrastructure

- **Bug Fixes:**
    - Fixed musl libc pthread compatibility issues
    - Fixed Python 3.13 build infrastructure compatibility
    - Resolved gettext GETTEXTIZE variable conflicts
    - Applied busybox security patches

- **Documentation:**
    - Added `spec/MD5_TO_SHA256_MIGRATION_PLAN.md` - comprehensive migration guide
    - Updated all OTA documentation for SHA256 workflow
    - Updated README.md, CUSTOMIZATION_AND_OTA.md, OTA_SERVER_DOCKER.md
    - Added ttyd security hardening guide
    - Added eFuse decoder utility documentation
    - Updated `.gitignore` (3 line changes)

- **Testing & Validation:**
    - Static code analysis confirms complete MD5 removal
    - Build system validated with musl/RISC-V architecture
    - CI/CD pipelines tested for SHA256 generation
    - Docker build improvements verified

- **Statistics:**
    - **Total Changes:** 168 files changed
    - **Additions:** +9,930 lines
    - **Deletions:** -1,142 lines
    - **Net:** +8,788 lines
    - **New Packages:** 29 added
    - **Removed Packages:** 2 deleted
    - **Updated Packages:** 15 modified

## 0.2.1 (2025-09-12)

### sg2002_recamera_emmc

- New Features:
    - File browser
    - SSH on/off
    - Optimize network connection
    - Upgrade node-red to 4.1.0
    - Add CDC support
    - Specified node-reddash@1.26.0
    - Increase ION size to 60M
    - Set TPU max to 700MHz

- Bug Fixes:
    - Resolved 'isp err chk:7271(): CSIBDG A fifo overflow'
    - Resolved some other bugs

## 0.2.0 (2025-03-31)

### sg2002_recamera_emmc

- New Features:
    - Add gimbal automatic calibration
    - Add Node-red gimbal flow

- Bug Fixes:
    - Resolved various bugs in the SSCMA

## 0.1.5 (2025-01-22)

### sg2002_recamera_emmc

- New Features:
    - Added support for device discovery
    - Added support for 63-byte WiFi passwords
    - Added support for audio recording
    - Added ability to enable/disable nodes in the SSCMA Node
    - Introduced a more user-friendly interface for improved interaction

- Bug Fixes:
    - Resolved various bugs in the SSCMA Node
    - Resolved various bugs in the SSCMA Supervisor

If you need any more modifications, feel free to ask!
## 0.1.4 (2024-12-23)

### sg2002_recamera_emmc

- New features:
    - support fip and boot partition auto update
    - support /mnt/system/upgrade.sh start *ota.zip
    - support gimbal (spi-can mcp2518fd)
    - add cvi_pinmux tool
    - use udev instead of mdev
    - udev rules for sd auto mount

- Fix bugs:
    - factory reset failed (if sg2002_recamera_emmc_md5sum.txt is not exist)
    - solve the problem that the pc cannot access the Internet when connected via usb
    - dnsmasq fails to run without wifi

## 0.1.3 (2024-11-08)

### sg2002_recamera_emmc

- New features:
    - support 64G emmc

## 0.1.2 (2024-11-01)

### sg2002_recamera_emmc

- New features:
    - support global.gc operation
    - built-in model files

- Fix bugs:
    - solve some supervisor bugs
    - solve some sscma-node bugs

## 0.1.1 (2024-10-30)

### sg2002_recamera_emmc

- New features:
    - limit node-red to version 3.1.14

- Fix bugs:
    - solve some supervisor bugs
    - fix sd_gen_recovery_image.sh script bugs

## 0.1.0 (2024-10-28)

### sg2002_recamera_emmc

- New features:
    - update ov5647 isp params (denoise)
    - optimize ota

## 0.0.9 (2024-10-26)

### sg2002_recamera_emmc

- New features:
    - enable nodejs --v8-lite-mode (disable WebAssembly)
    - optimize system upgrade operations

- Fix bugs:
    - remove node-red-dashboard from node-red
    - solve some sscma-node bug

## 0.0.8 (2024-10-22)

### sg2002_recamera_emmc

- New features:
    - auto swapon /userdata/.swapfile
    - reduce node-red startup time (skip npm -v)
    - supervior
        - add the operation that AP will automatically turn on or off according to the status of WiFi
        - split the wifi scan into two operations: scan wifi and get scan results
        - add a judgement that an upgrade is in progress

- Fix bugs:
    - solve some supervisor bug
    - solve some sscma-node bug

## 0.0.7 (2024-10-16)

### sg2002_recamera_emmc

- New features:
    - reduce ION_SIZE to 50M
    - kernel support swap
    - kernel support advise syscalls
    - update c-ares to 1.32.2
    - update libuv to 1.48.0
    - update nodejs to 22.8.0
    - update node-red to 4.0.0
    - sd supports hotplug
    - close swupdate auto start (`sudo /usr/lib/swupdate/swupdate.sh`)

- Fix bugs:
    - solve some supervisor bug
    - solve some sscma-node bug

## 0.0.6 (2024-10-12)

### sg2002_recamera_emmc

- New features:
    - sensor auto detection (ov5647/sc530ai)
    - supports restore to factory
    - get mac & sn from efuse
    - add sscma-node program
    - supervisor
        - support https service
        - add service status detection
        - add a feature for file management
        - add wifi password verification operation

- Fix bugs:
    - solve some compilation issues
    - solve some supervisor bugs

## 0.0.5 (2024-09-25)

### sg2002_recamera_emmc

- New features:
    - update node-red interface style
    - supervisor
        - add APIs for uploading models and getting model information
        - allow CORS

- Fix bugs:
    - fix the problem that some configuration files did not exist
    - node-red start failed when reset system
    - solve some supervisor bugs

- Docs:
    - add compilation notes

## 0.0.4 (2024-09-12)

### sg2002_recamera_emmc

- New features:
    - buildin supervisor
    - buildin npm@8.11.0 and node-red@v3.1.11
    - update ov5647 isp params
    - supports rootfs overlay (/bin /etc /lib /home /root /usr /var)
    - add recamera as default user
    - supports sudo
    - upgrade icu to 73-2

- Fix bugs:
    - upgrade.sh checksum failed
    - fixed ov5647 mirror

## 0.0.3 (2024-08-30)

### sg2002_recamera_emmc
- update sdk upstream (6cd7a5b)
- support more buildroot packages (mosquitto/avahi/opkg/live555)
- remove reCamera app
- change ota (not compatible with last version) and supports swupdate
- use ncm replace of rndis
- expand rootfs size to 512M, rootfs default readonly (rootfs_rw (on|off))
- auto mount /dev/mmcblk0p6 to /userdata
- update nodejs to 17.9.1

## 0.0.2 (2024-06-24)

### sg2002_recamera_emmc
- update sdk upstream
- support booting from sd (sg2002_reCamera_0.0.2_emmc_sd_compat.zip)
- support sd recovery (sg2002_reCamera_0.0.2_emmc_recovery.zip)

## 0.0.1 (2024-06-21)

### sg2002_recamera_emmc
- First beta release
- SDK: supported emmc/sdcard/leds/wifi/uart/ethernet/ov5647 sensor
- APP: complete basic functions(Overview/Security/Newwork/Terminal/Setting)
