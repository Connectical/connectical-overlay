# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:$

inherit eutils linux-mod

DESCRIPTION="Toshiba bluetooth kernel module"
HOMEPAGE="http://0bits.com/toshbt"
SRC_URI="http://0bits.com/toshbt/${PN}-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="|| ( =virtual/linux-sources-2.6.22*
			 =virtual/linux-sources-2.6.23*
			 =virtual/linux-sources-2.6.24* )"
RDEPEND="${DEPEND}"


S="${WORKDIR}/${PN}"
MODULE_NAMES="toshbt(misc:)"
BUILD_TARGETS=" "
# Fix path to source directory

pkg_setup() {
	if kernel_is lt 2 6 22 ; then
		eerror "toshbt requires a kernel >=2.6.22."
		eerror "Please set your /usr/src/linux symlink accordingly."
		die "invalid /usr/src/linux symlink"
	elif kernel_is gt 2 6 24 ; then
		eerror "toshbt is not tested under kernel > 2.6.24"
		eerror "Please downgrade your kernel to 2.6.24"
		die "invalid /usr/src/linux symlink"
	else
		CONFIG_CHECK="ACPI ACPI_TOSHIBA BT_HCIUSB"
	fi


	linux-mod_pkg_setup

	BUILD_PARAMS="KSRC=${KV_DIR}"
}

src_compile() {
	linux-mod_src_compile
}

src_install() {
	linux-mod_src_install
	dodoc README
}
