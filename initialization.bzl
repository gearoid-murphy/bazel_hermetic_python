load("@rules_foreign_cc//foreign_cc:repositories.bzl", "rules_foreign_cc_dependencies")
load("@rules_perl//perl:deps.bzl", "perl_register_toolchains", "perl_rules_dependencies")

def register_hermetic_python_subsystems():
  rules_foreign_cc_dependencies(register_default_tools = True)
  perl_rules_dependencies()
  perl_register_toolchains()

