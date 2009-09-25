# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MY_P="${P/spawning/Spawning}"

inherit distutils


DESCRIPTION="WSGI server built on top of eventlet"
HOMEPAGE="http://pypi.python.org/pypi/Spawning"
SRC_URI="http://pypi.python.org/packages/source/S/Spawning/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc"
IUSE=""

S="${WORKDIR}/${MY_P}"

DEPEND="dev-python/setuptools
	>=dev-python/simplejson-1.7.1
	>=dev-python/pastedeploy-1.3
	>=dev-python/eventlet-0.7"
RDEPEND="${DEPEND}"

