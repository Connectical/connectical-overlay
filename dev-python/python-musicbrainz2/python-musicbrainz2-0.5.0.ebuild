# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit distutils

DESCRIPTION="Pure-Python musicbrainz client library"
HOMEPAGE="http://musicbrainz.org/doc/PythonMusicBrainz2"
SRC_URI="http://ftp.musicbrainz.org/pub/musicbrainz/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc"
IUSE=""

#DEPEND=""
RDEPEND=">=media-libs/libdiscid-0.1.1
	|| (
		>=dev-lang/python-2.5
		>=dev-python/ctypes-1.0.1
	)"

