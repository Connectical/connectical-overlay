# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils toolchain-funcs

KEYWORDS="~x86 ~amd64 ~ppc64"

DESCRIPTION="Fast, reliable, simple package for creating and reading dynamic databases."
HOMEPAGE="http://www.ohse.de/uwe/dyndb.html"
SRC_URI="http://www.ohse.de/uwe/dyndb/${P}.tar.gz"
LICENSE="GPL"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${WORKDIR}/data/${P}"
	epatch "${FILESDIR}"/${P}-errno.diff
	epatch "${FILESDIR}"/${P}-compile.diff
}

src_compile() {
	cd "${WORKDIR}/data/${P}"
	emake || die "emake failed"
}

src_install() {
	cd "${WORKDIR}/data/${P}"

	dobin command/* || die "dobin failed"
	doman doc/* || die "doman failed"
}
