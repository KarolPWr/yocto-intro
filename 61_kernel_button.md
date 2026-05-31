


# Button interrupt counter

Summary of changes:

   1. Kernel Driver:
       * Created layers/meta-ifm/recipes-kernel/button-counter/ containing the C source and BitBake recipe.
       * This driver uses GPIOC 5 and exposes the count via /sys/bus/platform/devices/my_button_counter/count.
   2. Device Tree Overlay:
       * Created layers/meta-ifm/recipes-kernel/linux-devicetree/dtbo-button-counter.bb.
       * Created layers/meta-ifm/recipes-kernel/linux-devicetree/dtbo-button-counter/button-counter-overlay.dts.
       * The overlay disables the default button-user-1 to free up the GPIO and adds the custom,button-counter node.
   3. Configuration:
       * Updated build-openstlinuxweston-stm32mp25-disco/conf/local.conf to automatically compile the overlay, load it at
         boot, and include the driver in your image.

Once the board boots:
   1. Verify the driver is loaded: lsmod | grep button_counter
   2. Check the counter: cat /sys/bus/platform/devices/my_button_counter/count
   3. Press the User-1 button and watch the counter increment!
