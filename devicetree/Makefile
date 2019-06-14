SHELL := /bin/sh

# Terminal color control strings
RED=\e[1;31m
GRN=\e[1;32m
YEL=\e[1;33m
BLU=\e[1;34m
MAG=\e[1;35m
CYN=\e[1;36m
END=\e[0m

UBOOT_SRCDIR = ../../../../denx.de/u-boot
BUILD_FILES = gpu.dtbo mmc2.dtbo nand.dtbo pocketchip-v72.dtbo pocketchip-v73.dtbo sun5i-r8-chip.dtb

DTC = $(UBOOT_SRCDIR)/scripts/dtc/dtc

.PHONY: all clean

all: $(BUILD_FILES)

clean:
	$(RM) $(BUILD_FILES) sun5i-r8-chip.dts.preprocessed

$(DTC):
	$(MAKE) -C $(UBOOT_SRCDIR) scripts

define RUN-CPP =
$(CPP) -nostdinc -I$(UBOOT_SRCDIR)/include -I$(UBOOT_SRCDIR)/arch/arm/dts -undef -x assembler-with-cpp $< >$@
endef

sun5i-r8-chip.dts.preprocessed: $(UBOOT_SRCDIR)/arch/arm/dts/sun5i-r8-chip.dts
	$(RUN-CPP)

%.dts.preprocessed: %.dts
	$(RUN-CPP)

define RUN-DTC =
$(DTC) -@ -I dts -O dtb -o $@ $<
endef

%.dtbo: %.dts.preprocessed $(DTC)
	$(RUN-DTC)

sun5i-r8-chip.dtb: sun5i-r8-chip.dts.preprocessed $(DTC)
	$(RUN-DTC)

%.dtb: %.dts.preprocessed $(DTC)
	$(RUN-DTC)
