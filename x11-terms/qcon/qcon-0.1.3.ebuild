# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit distutils

DESCRIPTION="Turns any terminal emulator for X into quake-style console"
HOMEPAGE="http://qcon.spirali.ru/"
SRC_URI="${HOMEPAGE}/get/${P}.tar.gz"

S="${WORKDIR}/${PN}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc ~ppc64"
IUSE=""

DEPEND=">=dev-lang/python-2.5
	>=dev-python/pygtk-1.12
	>=dev-python/gnome-python-desktop-2.20
	>=dev-python/python-xlib-0.12"
RDEPEND="${DEPEND}"

