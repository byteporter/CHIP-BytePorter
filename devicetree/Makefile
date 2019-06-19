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
OVERLAY_BUILD_FILES = gpu.dtbo mmc2.dtbo nand.dtbo pocketchip_v72.dtbo pocketchip_v73.dtbo
DT_BUILD_FILES = sun5i-r8-chip.dtb sun5i-r8-popcorn.dtb
BUILD_FILES = $(OVERLAY_BUILD_FILES) $(DT_BUILD_FILES)
INSTALL_PREFIX = .

DTC = $(UBOOT_SRCDIR)/scripts/dtc/dtc

.PHONY: all clean archive install

all: $(BUILD_FILES)

clean:
	$(RM) $(BUILD_FILES) byteporter-devicetree.tar.gz sun5i-r8-chip.dts.preprocessed

archive: byteporter-devicetree.tar.gz

install: byteporter-devicetree.tar.gz | $(INSTALL_PREFIX)
	tar xfz $< -C $(INSTALL_PREFIX)

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

%.dtb: %.dts.preprocessed $(DTC)
	$(RUN-DTC)

$(INSTALL_PREFIX):
	mkdir -p $(INSTALL_PREFIX)

byteporter-devicetree.tar.gz: $(BUILD_FILES)
	mkdir -p temp/dtb
	mkdir -p temp/dtbo
	cp $(OVERLAY_BUILD_FILES) temp/dtbo
	cp $(DT_BUILD_FILES) temp/dtb
	tar cfz $@ -C temp .
	$(RM) -r temp
