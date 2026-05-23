# Distro vs Image

Proposed Strategy:
   1. Custom Distro (ifm-distro): Handles global settings like DISTRO_FEATURES (AppArmor), hardware boot policies (emmc),
      and global class inheritance (build-info).
   2. Custom Image (ifm-image-weston): Handles image-specific package installations (nudoku, python3-flask) and feature
      removals (package-management).

  Categorization:
   * Distro Level: BOOTDEVICE_LABELS, STM32MP_DT_FILES_EMMC, DISTRO_FEATURES.
   * Image Level: IMAGE_FEATURES, CORE_IMAGE_EXTRA_INSTALL, IMAGE_INSTALL.


Rozwiązanie:

I have successfully migrated your configurations from local.conf to a clean, production-ready Hybrid (Distro + Image)
  structure within the meta-ifm layer.

  Key Changes:
   1. Custom Distro (ifm-distro):
       * Created layers/meta-ifm/conf/distro/ifm-distro.conf.
       * Moved global policies: BOOTDEVICE_LABELS, STM32MP_DT_FILES_EMMC, and DISTRO_FEATURES (apparmor).
       * Added INHERIT += "build-info", so your build info task now runs automatically for every recipe.

   2. Custom Image (ifm-image-weston):
       * Created layers/meta-ifm/recipes-st/images/ifm-image-weston.bb.
       * Configured image-specific removals (package-management, demo groups) and additions (python3-flask, nudoku).

   3. Environment Integration:
       * Updated init-bitbake-env.sh to default to ifm-distro.
       * Handled ST's envsetup.sh search limitations by setting META_LAYER_ROOT and TEMPLATECONF.
       * Cleaned up local.conf to keep it minimal.

  How to use your new setup:
  To build your custom image with the new distribution policy, simply run:

   1 ./bitbake-crops-wrapper.sh "source init-bitbake-env.sh && bitbake ifm-image-weston"

  You can verify that your build-info class is working globally by checking the output during the build or by running:

   1 bitbake -c generate_buildinfo nudoku

Step by step guide:

Creating a new image and distribution in Yocto is the standard way to move from "prototyping" in local.conf to a
  "production-ready" codebase. This guide breaks down the process into four logical steps.

  ---

  Step 1: Create a Custom Distribution (.conf)
  A Distribution defines the "OS Policy"—global settings that apply to every recipe in your project (e.g., kernel versions,
  security features, or global classes).

   1. Create the directory: mkdir -p layers/meta-YOUR-LAYER/conf/distro/
   2. Create the file: ifm-distro.conf (example name)
   3. Define the policy:

    1     # Base it on the existing ST distribution
    2     require conf/distro/openstlinux-weston.conf
    3
    4     DISTRO = "ifm-distro"
    5     DISTRO_NAME = "IFM OpenSTLinux Distro"
    6
    7     # Global Policy: Enable security features
    8     DISTRO_FEATURES:append = " apparmor"
    9
   10     # Global Class: Run this logic for every recipe automatically
   11     INHERIT += "build-info"

  Step 2: Create a Custom Image (.bb)
  An Image defines the "Content"—specifically which packages are installed on the final root filesystem.

   1. Create the directory: mkdir -p layers/meta-YOUR-LAYER/recipes-st/images/
   2. Create the file: ifm-image-weston.bb
   3. Define the contents:

    1     SUMMARY = "IFM custom image based on st-image-weston"
    2     LICENSE = "MIT"
    3
    4     # Start with the standard ST image
    5     require recipes-st/images/st-image-weston.bb
    6
    7     # Remove unwanted features or packages
    8     IMAGE_FEATURES:remove = "package-management"
    9     CORE_IMAGE_EXTRA_INSTALL:remove = "packagegroup-st-demo"
   10
   11     # Add your own packages
   12     IMAGE_INSTALL:append = " python3-flask nudoku"

  Step 3: Configure your Layer (layer.conf)
  Ensure your layer is configured to find the new distro and image files.

   1. Check conf/layer.conf: Verify it includes the path to your new files:

   1     # Add classes and distro paths
   2     BBPATH .= ":${LAYERDIR}"
   3
   4     # Add recipe paths
   5     BBFILES += "${LAYERDIR}/recipes-*/*/*.bb \
   6                 ${LAYERDIR}/recipes-*/*/*.bbappend"

  Step 4: Activate the New Configuration
  Finally, tell BitBake to use your new distro instead of the default one.

   1. Modify conf/local.conf:

   1     # Change the distro from openstlinux-weston to your own
   2     DISTRO = "ifm-distro"
   2. Update Initialization Scripts: If you use a setup script (like envsetup.sh), ensure it exports the correct variable:

   1     export DISTRO=ifm-distro

  ---

  Summary Table: Where does "Stuff" go?

  ┌────────────────────┬──────────────────────┬──────────────────────────────────────┐
  │ Configuration Type │ Recommended Location │ Example                              │
  ├────────────────────┼──────────────────────┼──────────────────────────────────────┤
  │ Global OS Features │ Distro (.conf)       │ DISTRO_FEATURES, INHERIT             │
  │ Hardware Policies  │ Distro (.conf)       │ BOOTDEVICE_LABELS, PREFERRED_VERSION │
  │ Software Selection │ Image (.bb)          │ IMAGE_INSTALL, IMAGE_FEATURES        │
  │ Local Overrides    │ local.conf           │ DL_DIR, SSTATE_DIR, PARALLEL_MAKE    │
  └────────────────────┴──────────────────────┴──────────────────────────────────────┘


