# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_DESIGNERPLUGIN="true"
PVCUT=$(ver_cut 1-2)
QTMIN=6.4.2
inherit ecm frameworks.kde.org

DESCRIPTION="Framework providing easy data-plotting functions"
LICENSE="LGPL-2+"
KEYWORDS=""
IUSE=""

DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[gui,widgets]
"
RDEPEND="${DEPEND}"
