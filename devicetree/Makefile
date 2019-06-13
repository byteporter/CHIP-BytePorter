SHELL := /bin/sh

# Terminal color control strings
RED=\e[1;31m
GRN=\e[1;32m
YEL=\e[1;33m
BLU=\e[1;34m
MAG=\e[1;35m
CYN=\e[1;36m
END=\e[0m

LINUX_SRCDIR = /usr/src/linux
BUILD_FILES = sun5i-r8-chip-byteporter.dtbo

.PHONY: all clean

all: $(BUILD_FILES)

clean:
	rm sun5i-r8-chip-byteporter.dtbo

%.dts.preprocessed: %.dts mmc2.dtsi nand.dtsi gpu.dtsi
	$(CPP) -nostdinc -I$(LINUX_SRCDIR)/include -I$(LINUX_SRCDIR)/arch -I$(LINUX_SRCDIR)/arch/arm/boot/dts -undef -x assembler-with-cpp $< >$@

%.dtbo: %.dts.preprocessed
	dtc -I dts -O dtb -o $@ $<

%.dtb: %.dts.preprocessed
	dtc -@ -I dts -O dtb -o $@ $<
