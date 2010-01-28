# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils ssl-cert toolchain-funcs perl-module

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
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"

IUSE="addition aio debug fastcgi flv imap ipv6 pcre perl pop random-index realip securelink smtp ssl static-gzip status sub webdav zlib
	fancyindex python scgi googleperf pam xslt push chunkin"

DEPEND="dev-lang/perl
	dev-libs/openssl
	pcre? ( >=dev-libs/libpcre-4.2 )
	zlib? ( sys-libs/zlib )
	perl? ( >=dev-lang/perl-5.8 )
	xslt? ( dev-libs/libxslt )
	python? ( >=dev-lang/python-2.4 )
	pam? ( virtual/pam )"

pkg_setup() {
	ebegin "Creating nginx user and group"
	enewgroup ${PN}
	enewuser ${PN} -1 -1 -1 ${PN}
	eend ${?}
	if use ipv6; then
		ewarn "Note that ipv6 support in nginx is still experimental."
		ewarn "Be sure to read comments on gentoo bug #274614"
		ewarn "http://bugs.gentoo.org/show_bug.cgi?id=274614"
	fi
}

src_unpack() {
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
	sed -i 's/ make/ \\$(MAKE)/' "${S}"/auto/lib/perl/make || die
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

	use addition && myconf="${myconf} --with-http_addition_module"
	use aio		&& myconf="${myconf} --with-file-aio"
	use ipv6	&& myconf="${myconf} --with-ipv6"
	use fastcgi	|| myconf="${myconf} --without-http_fastcgi_module"
	use fastcgi	&& myconf="${myconf} --with-http_realip_module"
	use flv		&& myconf="${myconf} --with-http_flv_module"
	use zlib	|| myconf="${myconf} --without-http_gzip_module"
	use pcre	|| {
		myconf="${myconf} --without-pcre --without-http_rewrite_module"
	}
	use debug	&& myconf="${myconf} --with-debug"
	use ssl		&& myconf="${myconf} --with-http_ssl_module"
	use perl	&& myconf="${myconf} --with-http_perl_module"
	use status	&& myconf="${myconf} --with-http_stub_status_module"
	use webdav	&& myconf="${myconf} --with-http_dav_module"
	use sub		&& myconf="${myconf} --with-http_sub_module"
	use realip	&& myconf="${myconf} --with-http_realip_module"
	use static-gzip		&& myconf="${myconf} --with-http_gzip_static_module"
	use random-index	&& myconf="${myconf} --with-http_random_index_module"
	use securelink		&& myconf="${myconf} --with-http_secure_link_module"
	use xslt    && myconf="${myconf} --with-http_xslt_module"

	if use smtp || use pop || use imap; then
		myconf="${myconf} --with-mail"
		use ssl && myconf="${myconf} --with-mail_ssl_module"
	fi
	use imap || myconf="${myconf} --without-mail_imap_module"
	use pop || myconf="${myconf} --without-mail_pop3_module"
	use smtp || myconf="${myconf} --without-mail_smtp_module"

	use googleperf  && myconf="${myconf} --with-google_perftools_module"
	use fancyindex  && myconf="${myconf} --add-module=../${FANCYINDEX}"
	use chunkin     && myconf="${myconf} --add-module=../${CHUNKIN}"
	use python      && myconf="${myconf} --add-module=../${WSGI}"
	use push        && myconf="${myconf} --add-module=../${PUSH}"
	use scgi        && myconf="${myconf} --add-module=../${SCGI}"
	use pam         && myconf="${myconf} --add-module=../${PAM}"

	tc-export CC
	./configure \
		--prefix=/usr \
		--with-cc-opt="-I${ROOT}/usr/include" \
		--with-ld-opt="-L${ROOT}/usr/lib" \
		--conf-path=/etc/${PN}/${PN}.conf \
		--http-log-path=/var/log/${PN}/access_log \
		--error-log-path=/var/log/${PN}/error_log \
		--pid-path=/var/run/${PN}.pid \
		--http-client-body-temp-path=/var/tmp/${PN}/client \
		--http-proxy-temp-path=/var/tmp/${PN}/proxy \
		--http-fastcgi-temp-path=/var/tmp/${PN}/fastcgi \
		${myconf} || die "configure failed"

	emake LINK="${CC} ${LDFLAGS}" OTHERLDFLAGS="${LDFLAGS}" || die "failed to compile"
}

src_install() {
	keepdir /var/log/${PN} /var/tmp/${PN}/{client,proxy,fastcgi}

	dosbin objs/nginx
	newinitd "${FILESDIR}"/nginx.init-r2 nginx || die

	cp "${FILESDIR}"/nginx.conf-r4 conf/nginx.conf

	dodir /etc/${PN}
	insinto /etc/${PN}
	doins conf/*

	dodoc CHANGES{,.ru} README

	# logrotate
	insinto /etc/logrotate.d
	newins "${FILESDIR}"/nginx.logrotate nginx || die

	use perl && {
		cd "${S}"/objs/src/http/modules/perl/
		einstall DESTDIR="${D}" INSTALLDIRS=vendor || die "failed to install perl stuff"
		fixlocalpod
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
		cp LICENSE   LICENSE.pam && dodoc LICENSE.pam
		cp README    README.pam  && dodoc README.pam
		cp ChangeLog NEWS.pam    && dodoc NEWS.pam
	fi
}

pkg_postinst() {
	use ssl && {
		if [ ! -f "${ROOT}"/etc/ssl/${PN}/${PN}.key ]; then
			install_cert /etc/ssl/${PN}/${PN}
			chown ${PN}:${PN} "${ROOT}"/etc/ssl/${PN}/${PN}.{crt,csr,key,pem}
		fi
	}
}
