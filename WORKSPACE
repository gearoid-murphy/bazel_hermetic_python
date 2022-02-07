workspace(name = "bazel-hermetic-python")

load(":repositories.bzl", "setup_hermetic_python_dependencies")
setup_hermetic_python_dependencies()
load(":initialization.bzl", "register_hermetic_python_subsystems")
register_hermetic_python_subsystems()
register_toolchains("//:hermetic_py_toolchain")
