# Yocto Configuration Migration Guide: From `local.conf` to Distro & Image

This guide outlines the step-by-step process for migrating configurations from `local.conf` into a custom **Distribution** and **Image** within a Yocto layer (e.g., `meta-ifm`).

---

## Step 1: Create a Custom Distribution (`.conf`)
A **Distribution** defines the "OS Policy"—global settings that apply to every recipe in your project.

1.  **Create the directory:**
    ```bash
    mkdir -p layers/meta-ifm/conf/distro/
    ```
2.  **Create the file:** `layers/meta-ifm/conf/distro/ifm-distro.conf`
3.  **Define the policy:**
    ```bitbake
    # Inherit from the base OpenSTLinux distribution
    require conf/distro/openstlinux-weston.conf

    DISTRO = "ifm-distro"
    DISTRO_NAME = "IFM OpenSTLinux Distro"

    # Move Hardware/Boot policies from local.conf
    BOOTDEVICE_LABELS += "emmc"
    STM32MP_DT_FILES_EMMC += "stm32mp257f-dk"

    # Move Global OS features from local.conf
    DISTRO_FEATURES:append = " apparmor"

    # Automatically inherit custom classes for all recipes
    INHERIT += "build-info"
    ```

---

## Step 2: Create a Custom Image (`.bb`)
An **Image** defines the "Content"—the specific set of packages and features installed on the root filesystem.

1.  **Create the directory:**
    ```bash
    mkdir -p layers/meta-ifm/recipes-st/images/
    ```
2.  **Create the file:** `layers/meta-ifm/recipes-st/images/ifm-image-weston.bb`
3.  **Define the contents:**
    ```bitbake
    SUMMARY = "IFM custom image based on st-image-weston"
    LICENSE = "MIT"

    # Require the base image you want to extend
    require recipes-st/images/st-image-weston.bb

    # Move image feature removals from local.conf
    IMAGE_FEATURES:remove = "package-management"
    IMAGE_FEATURES:remove = "packagegroup-framework-tools-audio"

    # Move package removals from local.conf
    CORE_IMAGE_EXTRA_INSTALL:remove = "packagegroup-st-demo"

    # Move additional package installations from local.conf
    IMAGE_INSTALL:append = " python3-flask nudoku"
    ```

---

## Step 3: Configure your Layer (`layer.conf`)
Ensure your layer is configured to find the new distro and image files.

1.  **Check `layers/meta-ifm/conf/layer.conf`**:
    *   `BBPATH` should include `${LAYERDIR}` to find the `conf/distro` directory.
    *   `BBFILES` should include your new `.bb` file path.

---

## Step 4: Activate the New Configuration
Update your environment to use the new names instead of the defaults.

1.  **Update `conf/local.conf`**:
    ```bitbake
    # Replace the default DISTRO
    DISTRO = "ifm-distro"

    # REMOVE the migrated lines from the end of local.conf
    ```

2.  **Update Initialization Scripts** (e.g., `init-bitbake-env.sh`):
    ```bash
    export DISTRO=ifm-distro
    ```

---

## Summary: Where does "Stuff" go?

| Configuration Type | Recommended Location | Purpose |
| :--- | :--- | :--- |
| **Global OS Policy** | Distro (`.conf`) | Security (AppArmor), global classes (`INHERIT`). |
| **Hardware Policy** | Distro (`.conf`) | Boot devices, Device Tree selections. |
| **Image Content** | Image (`.bb`) | Package lists (`IMAGE_INSTALL`), removals. |
| **Local Environment** | `local.conf` | Path settings (`DL_DIR`), user-specific tweaks. |

---

## Build Commands
After migration, initialize your environment and build your new image:
```bash
source init-bitbake-env.sh
bitbake ifm-image-weston
```
