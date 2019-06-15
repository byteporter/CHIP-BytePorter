m4_divert(`-1')
# This is an M4 tempalte file for generating the boot scripts for U-Boot. 
# Macros are defined in the recipe for boot.*.cmd files in the Makefile and
# passed in through the command line switches. __ROOTPART defaults to the
# currently mounted boot partition on your machine and __ADITIONAL_BOOTARGS is
# empty but both may be specified using environment variables when calling
# make, eg: 
#   $ ROOTPART=/dev/sda1 ADDITIONAL_BOOTARGS='cma=96M' make boot.linux-4.19.cmd
m4_include(`macros.m4')
m4_divert`'m4_dnl
setenv initrd_addr_r 0x44000000
setenv bootargs root=__ROOTPART ro __ADDITIONAL_BOOTARGS
m4_forloop(`i', `1', m4_defn(`__OVERLAY_CNT'), `setexpr fdto_`'__overlay(i)_addr_r $fdt_addr_r + m4_format(`0x%x', m4_eval(`(('i`-1) * 0x1000) + 0xf000'))
')`'m4_dnl

ext4load mmc 1:1 $kernel_addr_r /zImage`'__FILENAME_PATTERN
ext4load mmc 1:1 $initrd_addr_r /uinitrd`'__FILENAME_PATTERN
ext4load mmc 1:1 $fdt_addr_r /dtb/__DEVICE_TREE
m4_forloop(`i', `1', m4_defn(`__OVERLAY_CNT'), `ext4load mmc 1:1 $`'fdto_`'__overlay(i)_addr_r /dtbo/__overlay(i).dtbo
')`'m4_dnl

fdt addr $fdt_addr_r
fdt resize m4_format(`0x%x',m4_eval(`('__OVERLAY_CNT` + 1) * 0x1000'))
m4_forloop(`i', `1', m4_defn(`__OVERLAY_CNT'), `fdt apply $`'fdto_`'__overlay(i)_addr_r
')`'m4_dnl

bootz $kernel_addr_r $initrd_addr_r $fdt_addr_r
