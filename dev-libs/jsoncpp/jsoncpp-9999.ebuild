# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..11} )
inherit meson python-any-r1

MY_PN=jsoncpp
if [[ ${PV} == *9999* ]]; then
        EGIT_REPO_URI="https://github.com/open-source-parsers/${MY_PN}.git"
        inherit git-r3
else
    	SRC_URI="https://github.com/open-source-parsers/${PN}/archive/${PV}.tar.gz
		-> ${P}.tar.gz"
        KEYWORDS="~amd64 ~arm ~arm64 ~loong ~ppc ~ppc64 ~riscv ~x86"
fi

DESCRIPTION="C++ JSON reader and writer"
HOMEPAGE="https://github.com/open-source-parsers/jsoncpp"

LICENSE="|| ( public-domain MIT )"
SLOT="0/25"
#KEYWORDS="~alpha amd64 arm arm64 hppa ~ia64 ~loong ~m68k ~mips ppc ppc64 ~riscv ~s390 sparc x86 ~amd64-linux ~arm64-macos ~ppc-macos ~x64-macos ~x64-solaris"
KEYWORDS=""
IUSE="doc test"
RESTRICT="!test? ( test )"

BDEPEND="
	${PYTHON_DEPS}
	doc? ( app-doc/doxygen )"
RDEPEND=""

src_configure() {
	local emesonargs=(
		# Follow Debian, Ubuntu, Arch convention for headers location
		# bug #452234
		--includedir include/jsoncpp
		-Dtests=$(usex test true false)
	)
	meson_src_configure
}

src_compile() {
	meson_src_compile

	if use doc; then
		echo "${PV}" > version || die
		"${EPYTHON}" doxybuild.py --doxygen="${EPREFIX}"/usr/bin/doxygen || die
		HTML_DOCS=( dist/doxygen/jsoncpp*/. )
	fi
}

src_test() {
	# increase test timeout due to failures on slower hardware
	meson_src_test -t 2
}
