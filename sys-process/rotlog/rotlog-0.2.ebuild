# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="metalog inspired replacement for multilog"
HOMEPAGE="http://connectical.com/projects/rotlog"
SRC_URI="http://files.connectical.com/gentoo/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc ~ppc64"
IUSE=""

DEPEND="virtual/libc"


src_install () {
	dobin rotlog
	doman rotlog.8
}

