# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils gnome2

DESCRIPTION="Drop-down terminal for the Gnome desktop"
HOMEPAGE="http://www.guake-terminal.org"
SRC_URI="${HOMEPAGE}/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="libnotify"

DEPEND=">=x11-libs/vte-0.16.13
	>=dev-python/pygtk-2.10"
RDEPEND="${DEPEND}
	libnotify? ( dev-python/notify-python )"

pkg_setup () {
	if ! built_with_use x11-libs/vte python ; then
		elog
		elog "Support for the Python bindings of VTE must be available for"
		elog "${PN} to work. Please reinstall x11-libs/vte with the"
		elog "\"python\" USE-flag set and then try installing ${PN}"
		elog "again."
		elog
		die "x11-libs/vte with USE=\"python\" needed"
	fi
}

