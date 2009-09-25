# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

S="${WORKDIR}/itexToMML/itex-src"

DESCRIPTION="Itex2MML is WEB page with embedded LaTeX into XHTML and MathML converter."
HOMEPAGE="http://golem.ph.utexas.edu/~distler/blog/itex2MML.html"
SRC_URI="http://golem.ph.utexas.edu/~distler/blog/files/itexToMML.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

src_install() {
	dodir /usr/bin
	cp ${S}/itex2MML ${D}/usr/bin/
	dodoc ${S}/../README
}
