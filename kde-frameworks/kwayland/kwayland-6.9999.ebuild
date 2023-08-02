# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_TEST="true"
PVCUT=$(ver_cut 1-2)
QTMIN=6.4.2
inherit ecm frameworks.kde.org

DESCRIPTION="Qt-style client and server library wrapper for Wayland libraries"
HOMEPAGE="https://invent.kde.org/frameworks/kwayland"

LICENSE="LGPL-2.1"
KEYWORDS=""
IUSE=""

RESTRICT="test"

RDEPEND="
	>=dev-libs/wayland-1.15.0
	>=dev-qt/qtbase-${QTMIN}:6[concurrent,gui,egl]
	>=dev-qt/qtwayland-${QTMIN}:6
	media-libs/libglvnd
"
DEPEND="${RDEPEND}
	>=dev-libs/plasma-wayland-protocols-1.9.0
	>=dev-libs/wayland-protocols-1.15
	sys-kernel/linux-headers
"
BDEPEND="
	>=dev-util/wayland-scanner-1.19.0
"
