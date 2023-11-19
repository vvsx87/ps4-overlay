# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Autogenerated by pycargoebuild 0.10

EAPI=8

CRATES="
	addr2line@0.20.0
	adler@1.0.2
	aho-corasick@1.0.2
	android-tzdata@0.1.1
	android_system_properties@0.1.5
	anstream@0.3.2
	anstyle-parse@0.2.1
	anstyle-query@1.0.0
	anstyle-wincon@1.0.1
	anstyle@1.0.1
	anyhow@1.0.75
	async-io@1.13.0
	async-lock@2.7.0
	async-trait@0.1.72
	autocfg@1.1.0
	backtrace@0.3.68
	base64@0.21.3
	bitflags@1.3.2
	bitflags@2.3.3
	bitvec@1.0.1
	bumpalo@3.13.0
	byteorder@1.4.3
	bytes@1.4.0
	cc@1.0.80
	cfg-if@1.0.0
	chrono@0.4.26
	clap@4.3.19
	clap_builder@4.3.19
	clap_complete@4.3.2
	clap_derive@4.3.12
	clap_lex@0.5.0
	colorchoice@1.0.0
	concurrent-queue@2.2.0
	convert_case@0.4.0
	core-foundation-sys@0.8.4
	crossbeam-utils@0.8.16
	darling@0.20.3
	darling_core@0.20.3
	darling_macro@0.20.3
	deranged@0.3.6
	derivative@2.2.0
	derive-where@1.2.5
	derive_more@0.99.17
	dlib@0.5.2
	doc-comment@0.3.3
	downcast-rs@1.2.0
	enumflags2@0.6.4
	enumflags2_derive@0.6.4
	env_logger@0.10.0
	equivalent@1.0.1
	errno-dragonfly@0.1.2
	errno@0.3.2
	evdev@0.12.1
	event-listener@2.5.3
	fastrand@1.9.0
	fnv@1.0.7
	fork@0.1.22
	funty@2.0.0
	futures-channel@0.3.28
	futures-core@0.3.28
	futures-executor@0.3.28
	futures-io@0.3.28
	futures-lite@1.13.0
	futures-macro@0.3.28
	futures-sink@0.3.28
	futures-task@0.3.28
	futures-util@0.3.28
	futures@0.3.28
	gethostname@0.3.0
	gimli@0.27.3
	hashbrown@0.12.3
	hashbrown@0.14.0
	heck@0.4.1
	hermit-abi@0.3.2
	hex@0.4.3
	humantime@2.1.0
	hyprland-macros@0.3.4
	hyprland@0.3.12
	iana-time-zone-haiku@0.1.2
	iana-time-zone@0.1.57
	ident_case@1.0.1
	indexmap@1.9.3
	indexmap@2.0.0
	indoc@2.0.3
	instant@0.1.12
	io-lifetimes@1.0.11
	is-terminal@0.4.9
	itoa@1.0.9
	js-sys@0.3.64
	lazy_static@1.4.0
	libc@0.2.147
	libloading@0.8.0
	linux-raw-sys@0.3.8
	linux-raw-sys@0.4.5
	lock_api@0.4.10
	log@0.4.19
	memchr@2.6.4
	memoffset@0.6.5
	memoffset@0.7.1
	miniz_oxide@0.7.1
	mio@0.8.8
	nb-connect@1.2.0
	nix@0.22.3
	nix@0.23.2
	nix@0.26.2
	num-traits@0.2.16
	num_cpus@1.16.0
	object@0.31.1
	once_cell@1.18.0
	parking@2.1.0
	parking_lot@0.12.1
	parking_lot_core@0.9.8
	paste@1.0.14
	pin-project-lite@0.2.10
	pin-utils@0.1.0
	pkg-config@0.3.27
	polling@2.8.0
	proc-macro-crate@0.1.5
	proc-macro-crate@1.3.1
	proc-macro2@1.0.66
	quick-xml@0.28.2
	quote@1.0.32
	radium@0.7.0
	redox_syscall@0.3.5
	regex-automata@0.3.9
	regex-syntax@0.7.5
	regex@1.9.6
	rustc-demangle@0.1.23
	rustc_version@0.4.0
	rustix@0.37.23
	rustix@0.38.4
	rustversion@1.0.14
	ryu@1.0.15
	scoped-tls@1.0.1
	scopeguard@1.2.0
	semver@1.0.18
	serde@1.0.188
	serde_derive@1.0.188
	serde_json@1.0.105
	serde_repr@0.1.16
	serde_with@3.3.0
	serde_with_macros@3.3.0
	serde_yaml@0.9.25
	signal-hook-registry@1.4.1
	slab@0.4.8
	smallvec@1.11.0
	socket2@0.4.9
	static_assertions@1.1.0
	strsim@0.10.0
	strum@0.25.0
	strum_macros@0.25.2
	swayipc-types@1.3.0
	swayipc@3.0.1
	syn@1.0.109
	syn@2.0.28
	tap@1.0.1
	termcolor@1.2.0
	thiserror-impl@1.0.44
	thiserror@1.0.44
	time-core@0.1.1
	time-macros@0.2.11
	time@0.3.24
	tokio-macros@2.1.0
	tokio@1.29.1
	toml@0.5.11
	toml_datetime@0.6.3
	toml_edit@0.19.14
	unicode-ident@1.0.11
	unsafe-libyaml@0.2.9
	utf8parse@0.2.1
	waker-fn@1.1.0
	wasi@0.11.0+wasi-snapshot-preview1
	wasm-bindgen-backend@0.2.87
	wasm-bindgen-macro-support@0.2.87
	wasm-bindgen-macro@0.2.87
	wasm-bindgen-shared@0.2.87
	wasm-bindgen@0.2.87
	wayland-backend@0.1.2
	wayland-client@0.30.2
	wayland-protocols-wlr@0.1.0
	wayland-protocols@0.30.1
	wayland-scanner@0.30.1
	wayland-sys@0.30.1
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.5
	winapi-wsapoll@0.1.1
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-sys@0.48.0
	windows-targets@0.48.1
	windows@0.48.0
	windows_aarch64_gnullvm@0.48.0
	windows_aarch64_msvc@0.48.0
	windows_i686_gnu@0.48.0
	windows_i686_msvc@0.48.0
	windows_x86_64_gnu@0.48.0
	windows_x86_64_gnullvm@0.48.0
	windows_x86_64_msvc@0.48.0
	winnow@0.5.3
	wyz@0.5.1
	x11rb-protocol@0.12.0
	x11rb@0.12.0
	zbus@1.9.3
	zbus_macros@1.9.3
	zvariant@2.10.0
	zvariant_derive@2.10.0
"

inherit cargo udev

DESCRIPTION="Dynamic key remap for X and Wayland"
HOMEPAGE="https://github.com/k0kubun/xremap"
SRC_URI="
	https://github.com/k0kubun/xremap/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${CARGO_CRATE_URIS}
"

LICENSE="MIT"
# Dependent crate licenses
LICENSE+=" Apache-2.0 BSD GPL-3+ ISC MIT Unicode-DFS-2016"
SLOT="0"
KEYWORDS="~amd64"
IUSE="x11 gnome kde wlroots"
REQUIRED_USE="?? ( x11 gnome kde wlroots )"

RDEPEND="x11? ( x11-libs/libX11 )"

QA_FLAGS_IGNORED=".*"

src_configure() {
	local myfeatures=(
		$(usev x11)
		$(usev gnome)
		$(usev kde)
		$(usev wlroots)
	)
	cargo_src_configure --no-default-features
}

src_install() {
	cargo_src_install
	udev_newrules "${FILESDIR}"/xremap-input.rules 99-xremap-input.rules
}

pkg_postinst() {
	udev_reload
}

pkg_postrm() {
	udev_reload
}
