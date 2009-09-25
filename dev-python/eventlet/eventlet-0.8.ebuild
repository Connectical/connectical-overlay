# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit distutils

DESCRIPTION="Highly scalable coroutine-based networking library"
HOMEPAGE="http://wiki.secondlife.com/wiki/Eventlet"
SRC_URI="http://pypi.python.org/packages/source/e/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc"
IUSE="ssl"

DEPEND="dev-python/setuptools
	>=dev-python/greenlet-0.1
	>=dev-lang/python-2.4
	ssl? ( >=dev-python/pyopenssl-0.6 )"
RDEPEND="${DEPEND}"


pkg_postinst ()
{
	einfo
	einfo 'eventlet supports working with a number of event dispatcher'
	einfo 'libraries. You may want to install the following additional'
	einfo 'packages depending on the requirements of the eventlet-based'
	einfo 'applications that you will be using:'
	einfo
	einfo '  dev-libs/libevent - Provides native poll/epoll/kqueue'
	einfo '  dev-libs/libev    - Featureful alternative to libevent'
	einfo '  www-servers/nginx - WSGI apps embedded in the webserver [1]'
	einfo
	einfo 'Note [1]: You will need a mod_wsgi enabled Nginx build, like'
	einfo '          the ones built from this overlay with USE=python'
	einfo
}

