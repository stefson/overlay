# Copyright 2017-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=(python2_7)
PYTHON_REQ_USE="xml"

CRATES="
	Inflector-0.11.4
	adler-1.0.2
	ahash-0.4.7
	ahash-0.7.2
	aho-corasick-0.7.15
	align-data-0.1.0
	alloc-no-stdlib-2.0.1
	alloc-stdlib-0.2.1
	ansi_term-0.11.0
	anyhow-1.0.40
	anymap-0.12.1
	arrayvec-0.5.2
	ash-0.31.0
	ast_node-0.7.3
	async-compression-0.3.7
	async-stream-0.3.1
	async-stream-impl-0.3.1
	async-trait-0.1.50
	atty-0.2.14
	auto_impl-0.4.1
	autocfg-1.0.1
	base64-0.11.0
	base64-0.13.0
	bencher-0.1.5
	bit-set-0.5.2
	bit-vec-0.6.3
	bitflags-1.2.1
	block-0.1.6
	block-buffer-0.9.0
	brotli-3.3.0
	brotli-decompressor-2.3.1
	build_const-0.2.2
	bumpalo-3.6.1
	byteorder-1.4.3
	bytes-1.0.1
	cc-1.0.67
	cfg-if-0.1.10
	cfg-if-1.0.0
	cfg_aliases-0.1.1
	chrono-0.4.19
	clap-2.33.3
	cocoa-foundation-0.1.0
	convert_case-0.4.0
	copyless-0.1.5
	core-foundation-0.9.1
	core-foundation-sys-0.8.2
	core-graphics-types-0.1.1
	cpuid-bool-0.1.2
	crc-1.8.1
	crc32fast-1.2.1
	crossbeam-channel-0.5.1
	crossbeam-utils-0.8.3
	d3d12-0.3.2
	darling-0.10.2
	darling_core-0.10.2
	darling_macro-0.10.2
	dashmap-4.0.2
	data-encoding-2.3.2
	data-url-0.1.0
	deno_doc-0.3.0
	deno_lint-0.4.0
	derive_more-0.99.13
	digest-0.9.0
	dissimilar-1.0.2
	dlopen-0.1.8
	dlopen_derive-0.1.4
	dprint-core-0.35.3
	dprint-core-0.37.0
	dprint-plugin-json-0.10.1
	dprint-plugin-markdown-0.6.2
	dprint-plugin-typescript-0.44.1
	dprint-swc-ecma-ast-view-0.15.0
	dprint-swc-ecma-ast-view-0.16.0
	either-1.6.1
	encoding_rs-0.8.28
	endian-type-0.1.2
	enum-as-inner-0.3.3
	enum_kind-0.2.1
	env_logger-0.8.3
	errno-0.1.8
	errno-0.2.7
	errno-dragonfly-0.1.1
	exec-0.3.1
	fancy-regex-0.5.0
	filetime-0.2.14
	fixedbitset-0.2.0
	flate2-1.0.20
	fnv-1.0.7
	foreign-types-0.3.2
	foreign-types-shared-0.1.1
	form_urlencoded-1.0.1
	from_variant-0.1.3
	fs2-0.4.3
	fsevent-2.0.2
	fsevent-sys-3.0.2
	fslock-0.1.6
	futures-0.3.14
	futures-channel-0.3.14
	futures-core-0.3.14
	futures-executor-0.3.14
	futures-io-0.3.14
	futures-macro-0.3.14
	futures-sink-0.3.14
	futures-task-0.3.14
	futures-util-0.3.14
	fwdansi-1.1.0
	fxhash-0.2.1
	gcc-0.3.55
	generic-array-0.14.4
	getrandom-0.1.16
	getrandom-0.2.2
	gfx-auxil-0.8.0
	gfx-backend-dx11-0.7.0
	gfx-backend-dx12-0.7.1
	gfx-backend-empty-0.7.0
	gfx-backend-gl-0.7.1
	gfx-backend-metal-0.7.0
	gfx-backend-vulkan-0.7.0
	gfx-hal-0.7.0
	glob-0.3.0
	glow-0.7.2
	gpu-alloc-0.3.0
	gpu-alloc-types-0.2.0
	gpu-descriptor-0.1.1
	gpu-descriptor-types-0.1.1
	h2-0.3.2
	hashbrown-0.9.1
	heck-0.3.2
	hermit-abi-0.1.18
	hostname-0.3.1
	http-0.2.4
	http-body-0.4.1
	httparse-1.4.0
	httpdate-1.0.0
	humantime-2.1.0
	hyper-0.14.7
	hyper-rustls-0.22.1
	ident_case-1.0.1
	idna-0.2.3
	if_chain-1.0.1
	indexmap-1.6.2
	inotify-0.9.2
	inotify-sys-0.1.5
	inplace_it-0.3.3
	input_buffer-0.4.0
	instant-0.1.9
	ipconfig-0.2.2
	ipnet-2.3.0
	is-macro-0.1.9
	itoa-0.4.7
	jobserver-0.1.22
	js-sys-0.3.49
	jsonc-parser-0.17.0
	kernel32-sys-0.2.2
	khronos-egl-3.0.2
	lazy_static-1.4.0
	libc-0.2.93
	libloading-0.6.7
	linked-hash-map-0.5.4
	lock_api-0.4.3
	log-0.4.14
	lru-cache-0.1.2
	lsp-types-0.88.0
	lspower-1.0.0
	lspower-macros-0.2.0
	malloc_buf-0.0.6
	match_cfg-0.1.0
	matches-0.1.8
	memchr-2.3.4
	metal-0.21.0
	mime-0.3.16
	miniz_oxide-0.4.4
	mio-0.7.11
	miow-0.3.7
	naga-0.3.2
	new_debug_unreachable-1.0.4
	nibble_vec-0.1.0
	nix-0.20.0
	notify-5.0.0-pre.7
	ntapi-0.3.6
	num-bigint-0.2.6
	num-integer-0.1.44
	num-traits-0.2.14
	num_cpus-1.13.0
	objc-0.2.7
	objc_exception-0.1.2
	once_cell-1.7.2
	opaque-debug-0.3.0
	os_pipe-0.9.2
	owning_ref-0.4.1
	parking_lot-0.11.1
	parking_lot_core-0.8.3
	percent-encoding-2.1.0
	pest-2.1.3
	petgraph-0.5.1
	phf-0.8.0
	phf_generator-0.8.0
	phf_macros-0.8.0
	phf_shared-0.8.0
	pin-project-1.0.7
	pin-project-internal-1.0.7
	pin-project-lite-0.2.6
	pin-utils-0.1.0
	pmutil-0.5.3
	ppv-lite86-0.2.10
	precomputed-hash-0.1.1
	proc-macro-error-1.0.4
	proc-macro-error-attr-1.0.4
	proc-macro-hack-0.5.19
	proc-macro-nested-0.1.7
	proc-macro2-0.4.30
	proc-macro2-1.0.26
	pty-0.2.2
	pulldown-cmark-0.8.0
	quick-error-1.2.3
	quote-0.6.13
	quote-1.0.9
	radix_fmt-1.0.0
	radix_trie-0.2.1
	rand-0.7.3
	rand-0.8.3
	rand_chacha-0.2.2
	rand_chacha-0.3.0
	rand_core-0.5.1
	rand_core-0.6.2
	rand_hc-0.2.0
	rand_hc-0.3.0
	rand_pcg-0.2.1
	range-alloc-0.1.2
	raw-window-handle-0.3.3
	redox_syscall-0.2.6
	regex-1.4.3
	regex-syntax-0.6.23
	relative-path-1.3.2
	remove_dir_all-0.5.3
	reqwest-0.11.3
	resolv-conf-0.7.0
	retain_mut-0.1.2
	ring-0.16.20
	ron-0.6.4
	rustc_version-0.2.3
	rustls-0.19.1
	rustyline-8.0.0
	rustyline-derive-0.4.0
	ryu-1.0.5
	same-file-1.0.6
	scoped-tls-1.0.0
	scopeguard-1.1.0
	sct-0.6.1
	semver-0.9.0
	semver-parser-0.7.0
	semver-parser-0.10.2
	serde-1.0.125
	serde_derive-1.0.125
	serde_json-1.0.64
	serde_repr-0.1.6
	serde_urlencoded-0.7.0
	sha-1-0.9.4
	shell-escape-0.1.5
	signal-hook-registry-1.3.0
	siphasher-0.3.5
	slab-0.4.3
	slotmap-0.4.0
	smallvec-1.6.1
	socket2-0.3.19
	socket2-0.4.0
	sourcemap-6.0.1
	spin-0.5.2
	spirv_cross-0.23.1
	spirv_headers-1.5.0
	stable_deref_trait-1.2.0
	storage-map-0.3.0
	string_cache-0.8.1
	string_cache_codegen-0.5.1
	string_enum-0.3.1
	strsim-0.8.0
	strsim-0.9.3
	swc_atoms-0.2.6
	swc_bundler-0.32.5
	swc_common-0.10.17
	swc_ecma_ast-0.43.1
	swc_ecma_codegen-0.52.3
	swc_ecma_codegen_macros-0.5.2
	swc_ecma_dep_graph-0.22.2
	swc_ecma_parser-0.54.4
	swc_ecma_transforms-0.45.3
	swc_ecma_transforms_base-0.12.6
	swc_ecma_transforms_optimization-0.15.5
	swc_ecma_transforms_proposal-0.13.4
	swc_ecma_transforms_react-0.14.3
	swc_ecma_transforms_typescript-0.14.4
	swc_ecma_utils-0.34.2
	swc_ecma_visit-0.29.1
	swc_ecmascript-0.31.3
	swc_eq_ignore_macros-0.1.0
	swc_macros_common-0.3.3
	swc_visit-0.2.4
	swc_visit_macros-0.2.3
	syn-0.15.44
	syn-1.0.65
	syn-1.0.69
	sys-info-0.9.0
	tempfile-3.2.0
	termcolor-1.1.2
	text-size-1.1.0
	textwrap-0.11.0
	thiserror-1.0.24
	thiserror-impl-1.0.24
	thread_local-1.1.3
	thunderdome-0.3.0
	time-0.1.44
	tinyvec-1.2.0
	tinyvec_macros-0.1.0
	tokio-1.5.0
	tokio-macros-1.1.0
	tokio-rustls-0.22.0
	tokio-stream-0.1.5
	tokio-test-0.4.1
	tokio-tungstenite-0.14.0
	tokio-util-0.6.6
	toml-0.5.8
	tower-layer-0.3.1
	tower-service-0.3.1
	tower-test-0.4.0
	tracing-0.1.25
	tracing-attributes-0.1.15
	tracing-core-0.1.17
	trust-dns-client-0.20.2
	trust-dns-proto-0.20.2
	trust-dns-resolver-0.20.2
	trust-dns-server-0.20.2
	try-lock-0.2.3
	trybuild-1.0.42
	tungstenite-0.13.0
	twoway-0.2.1
	typenum-1.13.0
	ucd-trie-0.1.3
	unchecked-index-0.2.2
	unicase-2.6.0
	unicode-bidi-0.3.5
	unicode-normalization-0.1.17
	unicode-segmentation-1.7.1
	unicode-width-0.1.8
	unicode-xid-0.1.0
	unicode-xid-0.2.1
	untrusted-0.7.1
	url-2.2.1
	utf-8-0.7.6
	utf8parse-0.2.0
	uuid-0.8.2
	vec_map-0.8.2
	version_check-0.9.3
	walkdir-2.3.2
	want-0.3.0
	wasi-0.9.0+wasi-snapshot-preview1
	wasi-0.10.0+wasi-snapshot-preview1
	wasm-bindgen-0.2.72
	wasm-bindgen-backend-0.2.72
	wasm-bindgen-futures-0.4.22
	wasm-bindgen-macro-0.2.72
	wasm-bindgen-macro-support-0.2.72
	wasm-bindgen-shared-0.2.72
	web-sys-0.3.49
	webpki-0.21.4
	webpki-roots-0.21.1
	wgpu-core-0.7.1
	wgpu-types-0.7.0
	which-4.1.0
	widestring-0.4.3
	winapi-0.2.8
	winapi-0.3.9
	winapi-build-0.1.1
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-util-0.1.5
	winapi-x86_64-pc-windows-gnu-0.4.0
	winreg-0.6.2
	winreg-0.7.0
	winres-0.1.11
	wio-0.2.2
"

RUSTY_V8="0.22.1"
V8="9.1.269.5"
chromium_build="8e55a6521cfbec39fe736537483192ef6af54d36"
icu="28b0e9ea59878fdd1682593be2ac489a6a6bbb21"

inherit cargo check-reqs toolchain-funcs python-any-r1 git-r3

DESCRIPTION="A secure JavaScript and TypeScript runtime"
HOMEPAGE="https://github.com/denoland/deno"
EGIT_REPO_URI="https://github.com/denoland/rusty_v8"
EGIT_COMMIT="v${RUSTY_V8}"
EGIT_CHECKOUT_DIR="${WORKDIR}/rusty_v8"
EGIT_SUBMODULES=('third_party/jinja2' 'third_party/markupsafe' 'third_party/zlib' 'base/trace_event/common')
SRC_URI="
	https://github.com/denoland/deno/releases/download/v${PV}/deno_src.tar.gz -> ${P}.tar.gz
	https://github.com/v8/v8/archive/refs/tags/${V8}.tar.gz -> v8-${V8}.tar.gz
	https://github.com/denoland/chromium_build/archive/${chromium_build}.tar.gz -> deno_build-${chromium_build}.tar.gz
	https://github.com/denoland/icu/archive/${icu}.tar.gz -> deno_icu-${icu}.tar.gz
	$(cargo_crate_uris ${CRATES})
"

LICENSE="0BSD Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD-2 BSD CC0-1.0 ISC MIT MPL-2.0 Unlicense ZLIB"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror"
IUSE="libcxx"

BDEPEND="
	>=dev-libs/glib-2.66.7
	>=dev-util/gn-0.1807
	>=dev-util/ninja-1.10.0
	>=sys-devel/clang-10.0.0
	dev-lang/python:2.7[xml]
	libcxx? ( sys-libs/libcxx )
	>=dev-lang/rust-1.51.0[wasi,wasm]
"

S="${WORKDIR}/deno"

CHECKREQS_DISK_BUILD=23G

pkg_pretend() {
	check-reqs_pkg_pretend
}

pkg_setup() {
	check-reqs_pkg_setup
}

src_unpack() {
	git-r3_src_unpack
	#https://bugs.gentoo.org/783372
	cargo_src_unpack
}

src_prepare() {
	pushd "${EGIT_CHECKOUT_DIR}" >> /dev/null
	rm -rf v8 || die
	rm -rf build || die
	rm -rf third_party/icu || die
	mv "../v8-${V8}" v8 || die
	mv "../chromium_build-${chromium_build}" build || die
	mv "../icu-${icu}" third_party/icu || die
	eapply "${FILESDIR}/gentoo.patch"
	popd >> /dev/null
	echo "[patch.crates-io]" >> "${S}/Cargo.toml"
	echo "rusty_v8 = { path = '../rusty_v8' }" >> "${S}/Cargo.toml"
	default
}

src_configure() {
	python_setup

	export V8_FROM_SOURCE=1

	if ! tc-is-clang; then
		die "deno require CC=clang CXX=clang++"
	fi

	local clang_path=$($(tc-getCC) --print-prog-name clang)
	local clang_bin=$(dirname ${clang_path})
	# should be /usr/lib/llvm/12
	local clang_base=$(dirname ${clang_bin})
	local myconf_gn=""
	myconf_gn+="is_clang=true use_gold=false use_sysroot=false use_custom_libcxx=false"
	myconf_gn+=" custom_toolchain=\"//build/toolchain/linux/unbundle:default\""
	myconf_gn+=" host_toolchain=\"//build/toolchain/linux/unbundle:default\""
	myconf_gn+=" v8_snapshot_toolchain=\"//build/toolchain/linux/unbundle:default\""
	myconf_gn+=" clang_base_path=\"${clang_base}\""
	myconf_gn+=" fatal_linker_warnings=false"
	export GN_ARGS="${myconf_gn}"

	if use libcxx; then
		# for cc-rs
		export CXXSTDLIB=c++
	fi
	default
}

src_compile() {
	cd "${S}/cli"
	cargo_src_compile -vv
}

src_install() {
	dobin "${S}"/target/release/deno
	dobin "${S}"/target/release/denort
}
