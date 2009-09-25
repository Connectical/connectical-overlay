# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

ESVN_REPO_URI="svn://pollenation.net/forms/trunk"

inherit distutils python subversion

DESCRIPTION="HTML forms framework for Nevow"
HOMEPAGE="http://forms-project.pollenation.net"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS="~ppc ~x86 ~amd64"
IUSE=""

DEPEND=">=dev-python/nevow-0.8"


src_install () {
	distutils_src_install
	dodoc AUTHORS darcs-changelog

	python_version
	insinto "/usr/$(get_libdir)/python${PYVER}/site-packages/${PN}"
	doins formal/*.css
	insinto "/usr/$(get_libdir)/python${PYVER}/site-packages/${PN}/js"
	doins formal/js/*.js
	insinto "/usr/$(get_libdir)/python${PYVER}/site-packages/${PN}/html"
	doins formal/html/*.html
	insinto "/usr/$(get_libdir)/python${PYVER}/site-packages/${PN}/examples"
	doins formal/examples/*.css
}

