# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="A JavaScript that turns a layered Inkscape SVG image into a presentation."
HOMEPAGE="http://code.google.com/p/jessyink/"
VERSIONTAG="$(echo "${P}" | tr ji.- JI__)"
SRC_URI="http://jessyink.googlecode.com/files/$VERSIONTAG.zip"

LICENSE="GPL3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="media-gfx/inkscape"
RDEPEND="${DEPEND}"

src_install () {
	mkdir -p ${D}/usr/share/inkscape/extensions
	cp ${WORKDIR}/${VERSIONTAG}/inkscapeExtensions/*  ${D}/usr/share/inkscape/extensions
	dodoc ${WORKDIR}/${VERSIONTAG}/README.txt
	dodoc ${WORKDIR}/${VERSIONTAG}/JessyInk.svg
}
