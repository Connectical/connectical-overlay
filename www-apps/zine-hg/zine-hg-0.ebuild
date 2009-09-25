# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
EHG_REPO_URI="http://dev.pocoo.org/hg/zine-main"

inherit python mercurial

DESCRIPTION="Full-featured weblog engine written in Python"
HOMEPAGE="http://zine.pocoo.org"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=dev-lang/python-2.5"
RDEPEND="${DEPEND}
	>=dev-python/sqlalchemy-0.5
	>=dev-python/jinja2-2.1
	>=dev-python/werkzeug-0.5.1
	>=dev-python/lxml-2.0
	>=dev-python/pysqlite-2.3
	dev-python/html5lib
	dev-python/Babel
	dev-python/pytz
	|| ( dev-python/simplejson >=dev-lang/python-2.6 )
	!www-apps/zine"

S="${WORKDIR}/zine-main"

src_configure ()
{
	cd "${S}"
	chmod +x configure
	./configure --prefix=/usr
}

src_install ()
{
	make install DESTDIR="${D}"
}

