# Setup:

```
# Sync repos
repo init -u https://github.com/varigit/variscite-bsp-platform -b scarthgap -m imx-6.6.52-2.2.0.xml
repo sync -j$(nproc)

# Start container
./var-start-container.sh

# Initialize build env
MACHINE=imx93-var-som DISTRO=fsl-imx-wayland . var-setup-release.sh build_wayland

# Build
source setup-environment build_wayland
bitbake fsl-image-gui
bitbake fsl-image-gui
```

# Ref:
https://dev.variscite.com/var-som-mx93/mx93-yocto-scarthgap-6.6.52_2.2.0-v1.2/yocto-build-release/#create-a-bootable-sd-card
https://github.com/varigit/variscite-bsp-platform/tree/scarthgap
https://github.com/varigit/variscite-bsp-platform

