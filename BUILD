load("@rules_foreign_cc//foreign_cc:defs.bzl", "configure_make")


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
    name = "python_interpreter",
    args = ["-j 12"],
    configure_options = [
      # https://github.com/bazelbuild/rules_foreign_cc/issues/239
      "CFLAGS='-Dredacted=\"redacted\"'"
    ],
    deps = [":zlib", ":readline", ":ncurses"],
    out_static_libs = ["libpython3.8.a"],
    out_binaries = ["python3.8"],
    lib_source = "@python_interpreter//:all",
)

