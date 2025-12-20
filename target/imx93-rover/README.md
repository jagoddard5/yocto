# Overview:
Contains a yocto layer and yocto config dropin scripts for building a variscite system. Inclues support for TBD GPS/IMU, TBD 4g module

# Setup:

```
# Configure build system
./setup-build.sh

# Build
source setup-environment build-rover
bitbake fsl-image-gui
bitbake fsl-image-qt6

# Flash image
zstdcat tmp/deploy/images/imx93-var-som/fsl-image-gui-imx93-var-som.wic.zst | sudo dd of=/dev/sdc bs=1M conv=fsync
zstdcat tmp/deploy/images/imx93-var-som/fsl-image-qt6-imx93-var-som.wic.zst | sudo dd of=/dev/sdc bs=1M conv=fsync
```

# Ref:
https://dev.variscite.com/var-som-mx93/mx93-yocto-scarthgap-6.6.52_2.2.0-v1.2/yocto-build-release/#create-a-bootable-sd-card
https://github.com/varigit/variscite-bsp-platform/tree/scarthgap
https://github.com/varigit/variscite-bsp-platform
