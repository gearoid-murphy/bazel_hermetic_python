load("@rules_foreign_cc//foreign_cc:defs.bzl", "configure_make")
load("@bazel_tools//tools/python:toolchain.bzl", "py_runtime_pair")
package(default_visibility = ["//visibility:public"])


configure_make(
    name = "zlib",
    args = ["-j 12"],
    lib_source = "@zlib//:all",
    out_shared_libs = ["libz.so"]
)

configure_make(
    name = "readline",
    args = ["-j 12"],
    lib_source = "@readline//:all",
    out_shared_libs = ["libreadline.so"]
)

configure_make(
    name = "ncurses",
    lib_source = "@ncurses//:all",
    args = ["-j 12"],
    configure_options = [
      # rules_foreign_cc sets ARFLAGS to a value which causes a build failure
      # https://github.com/bazelbuild/rules_foreign_cc/issues/337
      "ARFLAGS=-curvU",
      # ncurses does not automatically build shared libs
      "--with-shared",
    ],
    out_shared_libs = [
      "libncurses.so",
      "libmenu.so",
      "libform.so",
      "libpanel.so"
    ]
)

configure_make(
    name = "openssl",
    args = ["-j 12"],
    configure_command = "config",
    configure_in_place = True,
    configure_options = [
        "no-comp",
        "no-idea",
        "no-weak-ssl-ciphers",
        "no-shared",
    ],
    env = select({
        "@platforms//os:macos": {
            "AR": "",
            "PERL": "$$EXT_BUILD_ROOT$$/$(PERL)",
        },
        "//conditions:default": {
            "PERL": "$$EXT_BUILD_ROOT$$/$(PERL)",
        },
    }),
    lib_source = "@openssl//:all",
    # Note that for Linux builds, libssl must come before libcrypto on the linker command-line.
    # As such, libssl must be listed before libcrypto
    out_static_libs = [
        "libssl.a",
        "libcrypto.a",
    ],
    targets = [
        "build_libs",
        "install_dev",
    ],
    toolchains = ["@rules_perl//:current_toolchain"],
)

configure_make(
    name = "python3",
    args = ["-j 12"],
    configure_options = [
        "CFLAGS='-Dredacted=\"redacted\"'",
        "--with-readline=$EXT_BUILD_DEPS/readline",
        "--with-openssl=$EXT_BUILD_DEPS/openssl",
        "--with-zlib=$EXT_BUILD_DEPS/zlib",
        "--with-ncurses=$EXT_BUILD_DEPS/ncurses",
        "--enable-optimizations",
    ],
    env = select({
        "@platforms//os:macos": {"AR": ""},
        "//conditions:default": {},
    }),
    features = select({
        "@platforms//os:macos": ["-headerpad"],
        "//conditions:default": {},
    }),
    # rules_foreign_cc defaults the install_prefix to "python".
    # This conflicts with the "python" executable that is generated.
    install_prefix = "py_install",
    lib_source = "@python3_interpreter//:all",
    out_binaries = [
        "python3.8",
    ],
    out_data_dirs = ["lib"],
    deps = [
        ":openssl",
        ":readline",
        ":ncurses",
        ":zlib",
    ],
)

filegroup(
    name = "python3_bin",
    srcs = [":python3"],
    output_group = "python3.8",
)

py_runtime(
    name = "py3_runtime",
    files = [":python3"],
    interpreter = ":python3_bin",
    python_version = "PY3",
)

py_runtime_pair(
    name = "py_runtime_pair",
    py2_runtime = None,
    py3_runtime = ":py3_runtime",
)

toolchain(
    name = "hermetic_py_toolchain",
    toolchain = ":py_runtime_pair",
    toolchain_type = "@bazel_tools//tools/python:toolchain_type",
)

py_binary(
    name = "pyrun",
    srcs = ["pyrun.py"],
)
