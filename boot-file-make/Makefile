SHELL := /bin/sh
BUILDDIR ?= .
TEMPLATEDIR ?= .

.PHONY:

$(BUILDDIR)/%.sh: $(BUILDDIR)/%.config.m4 $(TEMPLATEDIR)/template.m4
	m4 -P $^ >$@
