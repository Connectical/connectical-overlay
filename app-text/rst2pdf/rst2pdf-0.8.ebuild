# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit distutils

DESCRIPTION="Tool for transforming reStructuredText to PDF using ReportLab"
HOMEPAGE="http://code.google.com/p/rst2pdf/"
SRC_URI="http://rst2pdf.googlecode.com/files/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc ~ppc64"
IUSE=""

DEPEND=">=dev-lang/python-2.4
	>=dev-python/docutils-0.4
	>=dev-python/reportlab-2.0
	>=dev-python/simplejson-1.7"
RDEPEND="${DEPEND}"

