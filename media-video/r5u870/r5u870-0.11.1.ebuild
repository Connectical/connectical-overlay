# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit linux-mod

DESCRIPTION="Driver for webcams based on the Ricoh r5u870 chip"
HOMEPAGE="http://wiki.mediati.org/R5u870"
SRC_URI="http://mediati.org/r5u870/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

MODULE_NAMES="r5u870(media/video:) usbcam/usbcam(media/video:)"
CONFIG_CHECK="VIDEO_V4L1 VIDEO_V4L2 VIDEO_V4L1_COMPAT FW_LOADER
	VIDEO_VIVI V4L_USB_DRIVERS"
MODULESD_R5U870_DOCS="README"
BUILD_TARGETS="all"

src_install () {
	linux-mod_src_install
	insinto /$(get_libdir)/firmware
	doins *.fw
	insinto /usr/share/doc/${P}
	doins "${FILESDIR}/vivi-dmasg-config.patch"
}

pkg_setup () {
	ewarn "If you get warnings about missing symbols, you may need to apply"
	ewarn "the supplied patch and rebuild your kernel, as follows:"
	ewarn
	ewarn "   # cd /usr/src/linux"
	ewarn "   # patch -p1 < /usr/share/doc/${P}/vivi-dmasg-config.patch"
	ewarn
	ewarn "Alternatively, you can edit the .config file and make sure that"
	ewarn "VIDEOBUF_DMA_SG, VIDEOBUF_GEN and VIDEOBUF_VMALLOC are set"
	ebeep 5 && epause
	linux-mod_pkg_setup
}
