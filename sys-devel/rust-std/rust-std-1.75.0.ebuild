# Copyright 2020-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..12} )

inherit crossdev flag-o-matic multiprocessing python-any-r1 rust-toolchain toolchain-funcs

DESCRIPTION="Rust standard library, standalone (for crossdev)"
HOMEPAGE="https://www.rust-lang.org"
SRC_URI="https://static.rust-lang.org/dist/rustc-${PV}-src.tar.xz"

LICENSE="|| ( MIT Apache-2.0 ) BSD-1 BSD-2 BSD-4"
SLOT="stable/$(ver_cut 1-2)"
# please do not keyword
#KEYWORDS="" #nowarn
IUSE="debug llvm-libunwind"

BDEPEND="
	${PYTHON_DEPS}
	~dev-lang/rust-${PV}:=
"

DEPEND="||
	(
		>="${CATEGORY}"/gcc-4.7:*
		>="${CATEGORY}"/clang-3.5:*
		>="${CATEGORY}"/clang-crossdev-wrappers-17.0:*
	)
"

RDEPEND="${DEPEND}"

# need full compiler to run tests
RESTRICT="test"

PATCHES=( "${FILESDIR}"/1.75.0-fix-bootstrap.patch )

QA_FLAGS_IGNORED="usr/lib/rust/${PV}/rustlib/.*/lib/lib.*.so"

S="${WORKDIR}/${P/-std/c}-src"

toml_usex() {
	usex "$1" true false
}

pkg_pretend() {
	target_is_not_host || die "${PN} should only be used for cross"
}

pkg_setup() {
	python-any-r1_pkg_setup
}

src_prepare() {
	default
}

src_configure() {
	# do the great cleanup
	strip-flags
	filter-flags '-mcpu=*' '-march=*' '-mtune=*' '-m32' '-m64'
	strip-unsupported-flags

	local rust_root x
	rust_root="$(rustc --print sysroot)"
	rtarget="$(rust_abi ${CTARGET})"
	rtarget="${ERUST_STD_RTARGET:-${rtarget}}" # some targets need to be custom.
	rbuild="$(rust_abi ${CBUILD})"
	rhost="$(rust_abi ${CHOST})"

	echo
	for x in CATEGORY rust_root rbuild rhost rtarget RUSTFLAGS CFLAGS CXXFLAGS LDFLAGS; do
		einfo "$(printf '%10s' ${x^^}:) ${!x}"
	done

	cat <<- EOF > "${S}"/config.toml
		change-id = 116881
		[llvm]
		download-ci-llvm = false
		[build]
		build = "${rbuild}"
		host = ["${rhost}"]
		target = ["${rtarget}"]
		cargo = "${rust_root}/bin/cargo"
		rustc = "${rust_root}/bin/rustc"
		submodules = false
		python = "${EPYTHON}"
		locked-deps = true
		vendor = true
		extended = true
		verbose = 2
		cargo-native-static = false
		[install]
		prefix = "${EPREFIX}/usr/lib/${PN}/${PV}"
		sysconfdir = "etc"
		docdir = "share/doc/rust"
		bindir = "bin"
		libdir = "lib"
		mandir = "share/man"
		[rust]
		# https://github.com/rust-lang/rust/issues/54872
		codegen-units-std = 1
		optimize = true
		debug = $(toml_usex debug)
		debug-assertions = $(toml_usex debug)
		debuginfo-level-rustc = 0
		backtrace = true
		incremental = false
		default-linker = "$(tc-getCC)"
		rpath = false
		dist-src = false
		remap-debuginfo = true
		jemalloc = false
		[dist]
		src-tarball = false
		[target.${rtarget}]
		ar = "${CTARGET}-ar"
		cc = "${CTARGET}-cc"
		cxx = "${CTARGET}-c++"
		linker = "${CTARGET}-cc"
		ranlib = "${CTARGET}-ranlib"
		$(usev elibc_musl 'crt-static = false')
		llvm-libunwind = "$(usex llvm-libunwind system no)"
	EOF

	if [[ "${CTARGET}" == *-musl* ]]; then
		cat <<- _EOF_ >> "${S}"/config.toml
			musl-root = "${EPREFIX}/usr/${CTARGET}/usr"
		_EOF_
	fi

	einfo "${PN^} configured with the following settings:"
	cat "${S}"/config.toml || die
}

src_compile() {
	env RUST_BACKTRACE=1 \
		"${EPYTHON}" ./x.py build -vv --config="${S}"/config.toml -j$(makeopts_jobs) \
		library/std --stage 0 || die
}

src_test() {
	ewarn "${PN} can't run tests"
}

src_install() {
	local rustlib="lib/rust/${PV}/lib/rustlib"
	dodir "/usr/${rustlib}"
	pushd "build/${rhost}/stage0-sysroot/lib/rustlib" > /dev/null || die
	cp -pPRv "${rtarget}" "${ED}/usr/${rustlib}" || die
	popd > /dev/null || die
}
