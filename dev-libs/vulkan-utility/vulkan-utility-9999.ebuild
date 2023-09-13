# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN=Vulkan-Utility-Libraries
PYTHON_COMPAT=( python3_{9..12} )
inherit cmake-multilib python-any-r1

if [[ ${PV} == *9999* ]]; then
	EGIT_REPO_URI="https://github.com/KhronosGroup/${MY_PN}.git"
	EGIT_SUBMODULES=()
	inherit git-r3
else
	SRC_URI="https://github.com/KhronosGroup/${MY_PN}/archive/sdk-${PV}.0.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~loong ~ppc ~ppc64 ~riscv"
	S="${WORKDIR}"/${MY_PN}-sdk-${PV}.0
fi

DESCRIPTION="Official Vulkan Utilities Libraries for Windows, Linux, Android, and MacOS"
HOMEPAGE="https://github.com/KhronosGroup/Vulkan-Utility-Libraries"

LICENSE="Apache-2.0"
SLOT="0"
IUSE="wayland +X"

BDEPEND="${PYTHON_DEPS}"
RDEPEND="
	~media-libs/vulkan-loader-${PV}:=[${MULTILIB_USEDEP},wayland?,X?]
	wayland? ( dev-libs/wayland:=[${MULTILIB_USEDEP}] )
	X? (
		x11-libs/libX11:=[${MULTILIB_USEDEP}]
		x11-libs/libXrandr:=[${MULTILIB_USEDEP}]
	)
"
DEPEND="${RDEPEND}
	~dev-util/vulkan-headers-${PV}
"

pkg_setup() {
	python-any-r1_pkg_setup
}

multilib_src_configure() {
	local mycmakeargs=(
		-DCMAKE_C_FLAGS="${CFLAGS} -DNDEBUG"
		-DCMAKE_CXX_FLAGS="${CXXFLAGS} -DNDEBUG"
		-DCMAKE_SKIP_RPATH=ON
		-DCMAKE_INSTALL_INCLUDEDIR="${ESYSROOT}/usr/include/vulkan/utility/"
	)

	cmake_src_configure
}