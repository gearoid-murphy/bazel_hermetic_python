load("@rules_foreign_cc//foreign_cc:defs.bzl", "configure_make")
load("@bazel_tools//tools/python:toolchain.bzl", "py_runtime_pair")
load(":adaptors.bzl", "get_executable", "get_runfiles")

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
    name = "python3_interpreter",
    args = ["-j 12"],
    configure_options = [
      # https://github.com/bazelbuild/rules_foreign_cc/issues/239
      "CFLAGS='-Dredacted=\"redacted\"'"
    ],
    deps = [":zlib", ":readline", ":ncurses"],
    out_static_libs = ["libpython3.8.a"],
    out_binaries = ["python3.8"],
    lib_source = "@python3_interpreter//:all",
)

get_executable(
    name = "python3_interpreter_executable",
    target = ":python3_interpreter",
)

py_runtime(
    name = "hermetic_python3_runtime",
    files = ["//:python3_interpreter"],
    interpreter = ":python3_interpreter_executable",
    python_version = "PY3",
    visibility = ["//visibility:public"],
)

py_runtime_pair(
    name = "hermetic_py_runtime_pair",
    py2_runtime = None,
    py3_runtime = ":hermetic_python3_runtime",
)

toolchain(
    name = "hermetic_py_toolchain",
    toolchain = ":hermetic_py_runtime_pair",
    toolchain_type = "@bazel_tools//tools/python:toolchain_type",
)


py_binary(
    name = "pyrun",
    srcs = ["pyrun.py"],
)
