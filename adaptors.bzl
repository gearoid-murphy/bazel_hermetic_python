# https://github.com/bazelbuild/bazel/issues/4286
def _get_executable_impl(ctx):
    return [DefaultInfo(files=depset([ctx.executable.target]))]

get_executable = rule(
    implementation = _get_executable_impl,
    attrs = {"target": attr.label(executable=True, cfg="target")},
)

def _get_runfiles_impl(ctx):
    info = ctx.attr.target[DefaultInfo]
    all_files = depset(transitive=[
        info.default_runfiles.files,
        info.data_runfiles.files,
        info.files,
    ])
    return [DefaultInfo(files=all_files)]

get_runfiles = rule(
    implementation = _get_runfiles_impl,
    attrs = {"target": attr.label(executable=True, cfg="target")},
)
