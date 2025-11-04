# Tag class for the extension API
_image = tag_class(
    attrs = {
        "name": attr.string(doc = "Name of the image repository"),
        "image": attr.string(doc = "Image reference (registry/repo:tag or registry/repo)"),
        "digest": attr.string(doc = "Image digest (sha256:...)"),
        "platforms": attr.string_list(doc = "Platforms to pull", default = ["linux/amd64", "linux/arm64"]),
    },
)

def _container_images_impl(mctx):
    """Implementation of container_images extension.

    This pulls the base images defined in tags and makes them available
    as repositories.
    """

    # Note: Since we're using rules_oci, we don't actually implement pulling here.
    # This is a documentation/configuration extension that users can reference.
    # The actual pulling is done via the oci.pull() calls in MODULE.bazel

    return mctx.extension_metadata(
        reproducible = True,
        root_module_direct_deps = "all",
        root_module_direct_dev_deps = [],
    )

container_images = module_extension(
    implementation = _container_images_impl,
    tag_classes = {
        "pull": _image,
    },
)

