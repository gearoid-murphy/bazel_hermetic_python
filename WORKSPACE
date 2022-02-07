workspace(name = "bazel-hermetic-python")

load(":repositories.bzl", "setup_hermetic_python_dependencies")
setup_hermetic_python_dependencies()

load("@rules_foreign_cc//foreign_cc:repositories.bzl", "rules_foreign_cc_dependencies")
load("@rules_perl//perl:deps.bzl", "perl_register_toolchains", "perl_rules_dependencies")

perl_rules_dependencies()
perl_register_toolchains()
rules_foreign_cc_dependencies(register_default_tools = True)

register_toolchains("//:hermetic_py_toolchain")
