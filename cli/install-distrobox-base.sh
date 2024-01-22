#!/usr/bin/env bash
# to make the first "distrobox enter" faster 
# from https://github.com/89luca89/distrobox/blob/3435f4d27070a99668bfa29a3e508db4ecc09009/distrobox-init#L410-L474
set -euox pipefail
deps="
	alpine-base
	bash
	bash-completion
	bc
	bzip2
	coreutils
	curl
	diffutils
	docs
	findmnt
	findutils
	gcompat
	gnupg
	gpg
	iproute2
	iputils
	keyutils
	less
	libc-utils
	libcap
	lsof
	man-pages
	mandoc
	mount
	musl-utils
	ncurses
	ncurses-terminfo
	net-tools
	openssh-client
	pigz
	pinentry
	posix-libc-utils
	procps
	rsync
	shadow
	su-exec
	sudo
	tar
	tcpdump
	tree
	tzdata
	umount
	unzip
	util-linux
	util-linux-misc
	vte3
	wget
	which
	xauth
	xz
	zip
	$(apk search -q mesa-dri)
	$(apk search -q mesa-vulkan)
	vulkan-loader
"
install_pkg=""
for dep in ${deps}; do
	if apk info "${dep}" > /dev/null; then
		install_pkg="${install_pkg} ${dep}"
	fi
done
# shellcheck disable=SC2086
apk add --force-overwrite ${install_pkg}
