# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit python gnome2

DESCRIPTION="Small accounting application for tracking bills"
HOMEPAGE="http://code.google.com/p/billreminder/"
SRC_URI="http://billreminder.googlecode.com/files/${P}.tar.bz2"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="|| (
		>=dev-lang/python-2.5
		>=dev-python/pysqlite-2.3
	)
	>=dev-python/pygtk-2.10
	>=dev-python/imaging-1.1
	>=dev-python/dbus-python-0.80"
RDEPEND="${DEPEND}"

