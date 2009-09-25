# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit python

MY_P="${P/zine/Zine}"

DESCRIPTION="Full-featured weblog engine written in Python"
HOMEPAGE="http://zine.pocoo.org"
SRC_URI="${HOMEPAGE}/releases/${MY_P}.tar.gz"

S="${WORKDIR}/${MY_P}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=dev-lang/python-2.4"
RDEPEND="${DEPEND}
	>=dev-python/sqlalchemy-0.5
	>=dev-python/jinja2-2.1
	>=dev-python/werkzeug-0.4
	>=dev-python/lxml-2.0
	>=dev-python/pysqlite-2.3
	dev-python/html5lib
	dev-python/Babel
	dev-python/pytz
	|| ( dev-python/simplejson >=dev-lang/python-2.6 )"


src_compile () {
	./configure --prefix=/usr
	make
}


src_install () {
	DESTDIR="${D}" make install
}

