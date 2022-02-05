workspace(name = "bazel-hermetic-python")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

RULES_FOREIGN_CC_VERSION="0.7.1"
http_archive(
    name = "rules_foreign_cc",
    sha256 = "bcd0c5f46a49b85b384906daae41d277b3dc0ff27c7c752cc51e43048a58ec83",
    strip_prefix = "rules_foreign_cc-{0}".format(RULES_FOREIGN_CC_VERSION),
    url = "https://github.com/bazelbuild/rules_foreign_cc/archive/{0}.tar.gz".format(RULES_FOREIGN_CC_VERSION),
)

load("@rules_foreign_cc//foreign_cc:repositories.bzl", "rules_foreign_cc_dependencies")

rules_foreign_cc_dependencies(register_default_tools = True)


all_content = """filegroup(name = "all", srcs = glob(["**"]), visibility = ["//visibility:public"])"""

ZLIB_VERSION="zlib-1.2.10"
http_archive(
    name = "zlib",
    build_file_content = all_content,
    strip_prefix = ZLIB_VERSION,
    urls = ["https://zlib.net/fossils/{0}.tar.gz".format(ZLIB_VERSION)],
)

READLINE_VERSION="readline-8.1"
http_archive(
    name = "readline",
    build_file_content = all_content,
    strip_prefix = READLINE_VERSION,
    urls = ["https://ftp.gnu.org/gnu/readline/{0}.tar.gz".format(READLINE_VERSION)],
)

NCURSES_VERSION="6.3"
http_archive(
    name = "ncurses",
    build_file_content = all_content,
    strip_prefix = "ncurses-{0}".format(NCURSES_VERSION),
    urls = ["https://github.com/mirror/ncurses/archive/refs/tags/v{0}.tar.gz".format(NCURSES_VERSION)],
)


PYTHON_VERSION="3.8.3"
http_archive(
    name = "python3_interpreter",
    urls = ["https://www.python.org/ftp/python/{0}/Python-{0}.tar.xz".format(PYTHON_VERSION)],
    sha256 = "dfab5ec723c218082fe3d5d7ae17ecbdebffa9a1aea4d64aa3a2ecdd2e795864",
    strip_prefix = "Python-{0}".format(PYTHON_VERSION),
    build_file_content = all_content,
)

register_toolchains("//:hermetic_py_toolchain")

