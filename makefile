# makefile - build system for this website's resources
#
# NOTE: assumes you have cwebp installed
#
# @author: Cade Brown <me@cade.site>


# all targets
all: files/favicon.webp files/kata-logo.webp


.PHONY: all

files/kata-logo.webp: files/kata-logo.svg
	convert -define webp:lossless=true -quality 95 $< $@

# regenerate favicon
files/favicon.webp: files/kata-logo.webp
	cwebp -lossless -resize 256 256 $< -o $@
