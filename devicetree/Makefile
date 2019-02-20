SHELL := /bin/sh

# Terminal color control strings
RED=\e[1;31m
GRN=\e[1;32m
YEL=\e[1;33m
BLU=\e[1;34m
MAG=\e[1;35m
CYN=\e[1;36m
END=\e[0m

CPREPROCESSOR ?= cpp
LINUX_SRCDIR ?= /usr/src/linux

.PHONY: all clean

all: mmc2.dtbo

clean:
	rm mmc2.dtbo mmc2.dts.preprocessed

%.dts.preprocessed: %.dts
	${CPREPROCESSOR} -nostdinc -I${LINUX_SRCDIR}/include -I${LINUX_SRCDIR}/arch -undef -x assembler-with-cpp $< $@

%.dtbo: %.dts.preprocessed
	dtc -I dts -O dtb -o $@ $<