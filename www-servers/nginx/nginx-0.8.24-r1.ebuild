# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/nginx/nginx-0.7.1.ebuild,v 1.1 2008/05/27 13:41:06 voxus Exp $

inherit eutils ssl-cert

DESCRIPTION="Robust, small and high performance http and reverse proxy server"

FANCYINDEX="ngx-fancyindex-0.2"
CHUNKIN="agentzh-chunkin-nginx-module-495af8c"
PUSH="nginx_http_push_module"
WSGI="mod_wsgi-8994b058d2db"
SCGI="mod_scgi-b466baa5fcdb"
PAM="ngx_http_auth_pam_module-1.1"

HOMEPAGE="http://nginx.net/"
SRC_URI="http://sysoev.ru/nginx/${P}.tar.gz
	fancyindex? ( http://files.connectical.com/gentoo/${FANCYINDEX}.tar.bz2 )
	chunkin? ( http://download.github.com/${CHUNKIN}.tar.gz )
	python? ( http://files.connectical.com/gentoo/${WSGI}.tar.gz )
	push? ( http://cloud.github.com/downloads/slact/nginx_http_push_module/${PUSH}-0.3.2.tar.gz )
	scgi? ( http://files.connectical.com/gentoo/${SCGI}.tar.gz )
	pam? ( http://web.iti.upv.es/~sto/nginx/${PAM}.tar.gz )"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

IUSE="addition debug fastcgi flv imap pcre perl ssl status sub webdav zlib
	fancyindex python scgi gzip-static googleperf pam ipv6 xslt push chunkin"

DEPEND="dev-lang/perl
	pcre? ( >=dev-libs/libpcre-4.2 )
	ssl? ( dev-libs/openssl )
	zlib? ( sys-libs/zlib )
	xslt? ( dev-libs/libxslt )
	perl? ( >=dev-lang/perl-5.8 )
	python? ( >=dev-lang/python-2.4 )
	pam? ( virtual/pam )"

pkg_setup() {
	ebegin "Creating nginx user and group"
	enewgroup nginx
	enewuser nginx -1 -1 /dev/null nginx
	eend ${?}
}

src_unpack () {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/use_x_forwarded_host.patch"

	if use python ; then
		cd "${WORKDIR}/${WSGI}"
		epatch "${FILESDIR}/nginx-0.6-mod_wsgi.patch"
		epatch "${FILESDIR}/nginx-wsgi-temp-path.patch"
	fi
	if use fancyindex ; then
		cd "${WORKDIR}/${FANCYINDEX}"
		epatch "${FILESDIR}/nginx-0.8-fancyindex.patch"
	fi
}

src_compile() {
	local myconf

	# threads support is broken atm.
	#
	# if use threads; then
	# 	einfo
	# 	ewarn "threads support is experimental at the moment"
	# 	ewarn "do not use it on production systems - you've been warned"
	# 	einfo
	# 	myconf="${myconf} --with-threads"
	# fi

	# Some things are enabled unconditionally
	myconf="${myconf} --with-http_realip_module"
	myconf="${myconf} --with-http_random_index_module"
	myconf="${myconf} --with-http_secure_link_module"

	use addition && myconf="${myconf} --with-http_addition_module"
	use fastcgi	|| myconf="${myconf} --without-http_fastcgi_module"
	use fastcgi	&& myconf="${myconf} --with-http_realip_module"
	use flv		&& myconf="${myconf} --with-http_flv_module"
	use zlib	|| myconf="${myconf} --without-http_gzip_module"
	use pcre	|| {
		myconf="${myconf} --without-pcre --without-http_rewrite_module"
	}
	use debug	&& myconf="${myconf} --with-debug"
	use ipv6    && myconf="${myconf} --with-ipv6"
	use ssl		&& myconf="${myconf} --with-http_ssl_module"
	use imap	&& myconf="${myconf} --with-imap" # pop3/imap4 proxy support
	use perl	&& myconf="${myconf} --with-http_perl_module"
	use status	&& myconf="${myconf} --with-http_stub_status_module"
	use webdav	&& myconf="${myconf} --with-http_dav_module"
	use sub		&& myconf="${myconf} --with-http_sub_module"
	use xslt    && myconf="${myconf} --with-http_xslt_module"

	use googleperf  && myconf="${myconf} --with-google_perftools_module"
	use gzip-static && myconf="${myconf} --with-http_gzip_static_module"
	use fancyindex  && myconf="${myconf} --add-module=../${FANCYINDEX}"
	use chunkin     && myconf="${myconf} --add-module=../${CHUNKIN}"
	use python      && myconf="${myconf} --add-module=../${WSGI}"
	use push        && myconf="${myconf} --add-module=../${PUSH}"
	use scgi        && myconf="${myconf} --add-module=../${SCGI}"
	use pam         && myconf="${myconf} --add-module=../${PAM}"

	./configure \
		--prefix=/usr \
		--conf-path=/etc/${PN}/${PN}.conf \
		--http-log-path=/var/log/${PN}/access_log \
		--error-log-path=/var/log/${PN}/error_log \
		--pid-path=/var/run/${PN}.pid \
		--http-client-body-temp-path=/var/tmp/${PN}/client \
		--http-proxy-temp-path=/var/tmp/${PN}/proxy \
		--http-fastcgi-temp-path=/var/tmp/${PN}/fastcgi \
		--with-md5-asm --with-md5=/usr/include \
		--with-sha1-asm --with-sha1=/usr/include \
		${myconf} || die "configure failed"

	emake || die "failed to compile"
}

src_install() {
	keepdir /var/log/${PN} /var/tmp/${PN}/{client,proxy,fastcgi}

	dosbin objs/nginx
	cp "${FILESDIR}"/nginx-r1 "${T}"/nginx
	doinitd "${T}"/nginx

	cp "${FILESDIR}"/nginx.conf-r4 conf/nginx.conf

	dodir "${ROOT}"/etc/${PN}
	insinto "${ROOT}"/etc/${PN}
	doins conf/*

	dodoc CHANGES{,.ru} README

	use perl && {
		cd "${S}"/objs/src/http/modules/perl/
		einstall DESTDIR="${D}"|| die "failed to install perl stuff"
	}

	if use fancyindex ; then
		cd "${WORKDIR}/${FANCYINDEX}"
		cp README.rst README.fancyindex
		dodoc README.fancyindex
	fi
	if use python ; then
		cd "${WORKDIR}/${WSGI}"
		cp LICENSE  LICENSE.wsgi && dodoc LICENSE.wsgi
		cp README   README.wsgi  && dodoc README.wsgi
		cp NEWS.txt NEWS.wsgi    && dodoc NEWS.wsgi
		cp BUGS     BUGS.wsgi    && dodoc BUGS.wsgi
		cp TODO     TODO.wsgi    && dodoc TODO.wsgi

		insinto /usr/share/doc/${PF}/wsgi_examples
		doins examples/*

		insinto /etc/nginx
		doins conf/wsgi_vars

		dosbin bin/*
	fi
	if use push ; then
		cd "${WORKDIR}/${PUSH}"
		cp README   README.push  && dodoc README.push
	fi
	if use scgi ; then
	  	cd "${WORKDIR}/${SCGI}"
	  	cp LICENSE  LICENSE.scgi && dodoc LICENSE.scgi
	  	cp README   README.scgi  && dodoc README.scgi

	  	insinto /etc/nginx
	  	doins conf/scgi_vars
	fi
	if use pam ; then
		cd "${WORKDIR}/${PAM}"
		cp LICENSE  LICENSE.pam && dodoc LICENSE.pam
		cp README   README.pam  && dodoc README.pam
		cp ChangLog NEWS.pam    && dodoc NEWS.pam
	fi
}

pkg_postinst() {
	use ssl && {
		if [ ! -f "${ROOT}"/etc/ssl/${PN}/${PN}.key ]; then
			dodir "${ROOT}"/etc/ssl/${PN}
			insinto "${ROOT}"etc/ssl/${PN}/
			insopts -m0644 -o nginx -g nginx
			install_cert /etc/ssl/nginx/nginx
		fi
	}
}
