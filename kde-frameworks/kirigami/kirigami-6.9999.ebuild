# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_EXAMPLES="true"
ECM_QTHELP="false"
ECM_TEST="true"
KDE_ORG_NAME="${PN}2"
QTMIN=6.4.2
inherit ecm frameworks.kde.org toolchain-funcs

DESCRIPTION="Lightweight user interface framework for mobile and convergent applications"
HOMEPAGE="https://techbase.kde.org/Kirigami"
EGIT_REPO_URI="${EGIT_REPO_URI/${PN}2/${PN}}"

LICENSE="LGPL-2+"
KEYWORDS=""
IUSE="+openmp"

# requires package to already be installed
RESTRICT="test"

DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[concurrent,dbus,gui,network,dbus]
	>=dev-qt/qtdeclarative-${QTMIN}:6
	>=dev-qt/qtsvg-${QTMIN}:6
"
RDEPEND="${DEPEND}"

BDEPEND=">=dev-qt/qttools-${QTMIN}:6[linguist]"

pkg_pretend() {
	[[ ${MERGE_TYPE} != binary ]] && use openmp && tc-check-openmp
}

pkg_setup() {
	[[ ${MERGE_TYPE} != binary ]] && use openmp && tc-check-openmp
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_EXAMPLES=$(usex examples)
		$(cmake_use_find_package openmp OpenMP)
	)

	ecm_src_configure
}
