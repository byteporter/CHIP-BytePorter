# This Makefile targets GNU Make

SHELL = /bin/sh

M4 = /usr/bin/m4
MKIMAGE = /usr/bin/mkimage

ROOTPART = $(shell mount | awk 'BEGIN{FS=" on "} / on \/ / {print $$1;}')
BOOTDIR = /boot/bootpart
ADDITIONAL_BOOTARGS =

DISTRO = $(shell source /etc/os-release; echo "$${ID}")
VERSION = $(shell uname -r)

FILENAME_PATTERN = -$(DISTRO)-$(VERSION)

BUILD_TARGETS = boot$(FILENAME_PATTERN).scr uinitrd$(FILENAME_PATTERN) zImage$(FILENAME_PATTERN)

OVERLAYS = mmc2 gpu pocketchip-v73
OVERLAY_CNT = $(words $(OVERLAYS))

NOOP=
SPACE=$(NOOP) $(NOOP)
COMMA=$(NOOP), $(NOOP)

.PHONY: clean all initrd uinitrd install install-default

all: $(BUILD_TARGETS)

ifneq (,$(wildcard Makefile.$(DISTRO)))
-include Makefile.$(DISTRO)
endif

clean:
	$(RM) \
	boot$(FILENAME_PATTERN).cmd \
	$(BUILD_TARGETS) \
	$(INCLUDED_BUILD_TARGETS)

boot$(FILENAME_PATTERN).scr: boot$(FILENAME_PATTERN).cmd
	@printf '$(CYN)Building $(YEL)$@$(END)\n'
	$(MKIMAGE) -A arm -T script -C none -n "Boot $(DISTRO)-$(VERSION)" -d $^ $@

boot$(FILENAME_PATTERN).cmd: boot.cmd.m4
	@printf '$(CYN)Building $(YEL)$@$(END)\n'
	$(M4) -P \
	-D__ROOTPART='$(ROOTPART)' \
	-D__OVERLAYS='$(subst $(SPACE),$(COMMA),$(OVERLAYS))' \
	-D__OVERLAY_CNT='$(OVERLAY_CNT)' \
	-D__ADDITIONAL_BOOTARGS='$(ADDITIONAL_BOOTARGS)' \
	-D__FILENAME_PATTERN='$(FILENAME_PATTERN)' \
	$^ >$@

# mkimage apparently creates and leaves the file behind even when it fails so the part at the end is to fix this behavior
uinitrd$(FILENAME_PATTERN): initrd$(FILENAME_PATTERN)
	@printf '$(CYN)Building $(YEL)$@$(END)\n'
	$(MKIMAGE) -A arm -O linux -T ramdisk -C gzip -n "Ramdisk $(DISTRO)-$(VERSION)" -d $^ $@ || ($(RM) $@; false)

install: $(BUILD_TARGETS)
	cp $^ $(BOOTDIR)

uninstall:
	$(RM) $(addprefix $(BOOTDIR)/,$(BUILD_TARGETS))

install-default: install
	ln -sf boot$(FILENAME_PATTERN).scr $(BOOTDIR)/boot.scr

# Terminal color control strings                                                                                                                                                               
RED=\e[1;31m
GRN=\e[1;32m
YEL=\e[1;33m
BLU=\e[1;34m
MAG=\e[1;35m
CYN=\e[1;36m
END=\e[0m
