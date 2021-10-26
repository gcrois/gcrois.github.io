# makefile - build system for this website's resources
#
# NOTE: assumes you have cwebp installed
#
# @author: Cade Brown <me@cade.site>

rwildcard=$(foreach d,$(wildcard $(1:=/*)),$(call rwildcard,$d,$2) $(filter $(subst *,%,$2),$d))

ALL_DOT := $(patsubst %.dot,%.dot.webp,$(call rwildcard,files,*.dot))


# all targets
all: files/favicon.webp files/kata-logo.webp $(ALL_DOT)


.PHONY: all

files/kata-logo.webp: files/kata-logo.svg
	convert -define webp:lossless=true -quality 95 $< $@

# regenerate favicon
files/favicon.webp: files/kata-logo.webp
	cwebp -lossless -resize 256 256 $< -o $@

# generate dots
%.dot.webp: %.dot
	dot -Twebp -o $@ $<
