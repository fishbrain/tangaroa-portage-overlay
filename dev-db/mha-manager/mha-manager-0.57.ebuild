# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit git-r3

DESCRIPTION="MySQL master HA manager"
HOMEPAGE="https://github.com/yoshinorim/mha4mysql-manager"
EGIT_REPO_URI="https://github.com/yoshinorim/mha4mysql-manager.git"
EGIT_COMMIT="c6db3eb66dec214a68dd5e9a51be1cda4ff19c8d"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-db/mha-node
	dev-perl/Config-Tiny
	dev-perl/DBD-mysql
	dev-perl/Log-Dispatch
	dev-perl/Module-Install
	dev-perl/Parallel-ForkManager
	virtual/perl-Time-HiRes"
RDEPEND="${DEPEND}
	!=dev-lang/perl-5.22.0"

src_configure() {
	perl Makefile.PL PREFIX=/usr INSTALLSITEMAN1DIR=/usr/share/man/man1
}

src_install() {
	emake DESTDIR="${D}" install

	# from perl-module.eclass; remove perllocal.pod
	find "${D}" -type f -name perllocal.pod -delete
	find "${D}" -depth -mindepth 1 -type d -empty -delete

	for d in README AUTHORS; do
		dodoc $d
	done

	newinitd "${FILESDIR}/mha-manager-initd" mha-manager
	newconfd "${FILESDIR}/mha-manager-confd" mha-manager

	insinto /etc/MHA
	for e in samples/conf/* ; do
		newins $e `basename ${e}.example`
	done

	insinto /etc/MHA/sample_scripts
	for s in samples/scripts/* ; do
		doins $s
	done
}

pkg_postinst() {
	ewarn "Do not forget to install mha-node on your MySQL / MariaDB server nodes before"
	ewarn "running the mha-manager service."
	ewarn
	ewarn "You will also need to make sure your host can connect to the DB servers over"
	ewarn "ssh with a passwordless key (make sure that the DB servers are in known_hosts"
	ewarn "as well)."
	ewarn
	ewarn "Finally, you will need to configure mha-manager before it can work for you."
	ewarn "Samples scripts and config files have been installed for you in /etc/MHA"
	ewarn "and a default /etc/conf.d/mha-manager file was created."
	ewarn
	ewarn "mha-manager will exit after it switches between master and slaves."
	ewarn "for this reason, we recommend you to add /sbin/rc to a cron job running every"
	ewarn "minute, if you intend to use the provided init script as a service."
}
