m4_divert(-1)
# This is an M4 tempalte file for generating the boot scripts for U-Boot. 
# Macros are defined in the recipe for boot.*.cmd files in the Makefile and
# passed in through the command line switches. __ROOTPART defaults to the
# currently mounted boot partition on your machine and __ADITIONAL_BOOTARGS is
# empty but both may be specified using environment variables when calling
# make, eg: 
#   $ ROOTPART=/dev/sda1 ADDITIONAL_BOOTARGS='cma=96M' make boot.linux-4.19.cmd
m4_include(`macros.m4')
m4_divert`'m4_dnl
m4_forloop(`i', `1', `3', `setexpr __overlay(i)_addr_r $fdt_addr_r + f000
')`'m4_dnl
setenv initrd_addr_r 0x44000000
setenv bootargs root=__ROOTPART ro __ADDITIONAL_BOOTARGS

ext4load mmc 1:1 $fdt_addr_r /dtb/sun5i-r8-chip.dtb
ext4load mmc 1:1 $fdto_addr_r /dtbo/sun5i-r8-chip-byteporter.dtbo
ext4load mmc 1:1 $kernel_addr_r /zImage`'__FILENAME_PATTERN
ext4load mmc 1:1 $initrd_addr_r /uinitrd`'__FILENAME_PATTERN

fdt addr $fdt_addr_r
fdt resize f000
fdt apply $fdto_addr_r

bootz $kernel_addr_r $initrd_addr_r $fdt_addr_r
