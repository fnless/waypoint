load(
    "@envoy//bazel:envoy_build_system.bzl",
    "envoy_cc_library",
    "envoy_cc_test",
    "envoy_proto_library",
)

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

envoy_cc_library(
    name = "filter_lib",
    srcs = ["filter.cc"],
    hdrs = ["filter.h"],
    repository = "@envoy",
    deps = [
        ":cluster_fallback_cc_proto",
        "@envoy//envoy/router:cluster_specifier_plugin_interface",
        "@envoy//source/common/router:config_lib",
    ],
)

envoy_cc_library(
    name = "config",
    srcs = ["config.cc"],
    hdrs = ["config.h"],
    repository = "@envoy",
    deps = [
        ":filter_lib",
        ":cluster_fallback_cc_proto",
        "@envoy//source/extensions/filters/network:well_known_names",
        "@envoy//source/extensions/filters/network/common:factory_base_lib",
    ],
)

envoy_proto_library(
    name = "cluster_fallback",
    srcs = ["cluster_fallback.proto"],
    deps = [],
)

envoy_cc_test(
    name = "config_test",
    srcs = ["config_test.cc"],
    deps = [
        ":config",
        ":cluster_fallback_cc_proto",
        "@envoy//test/mocks/server:factory_context_mocks",
        "@envoy//test/test_common:utility_lib",
    ],
)

envoy_cc_test(
    name = "filter_test",
    srcs = ["filter_test.cc"],
    deps = [
        ":config",
        ":filter_lib",
        ":cluster_fallback_cc_proto",
        "@envoy//test/mocks/server:factory_context_mocks",
        "@envoy//test/mocks/upstream:cluster_manager_mocks",
        "@envoy//test/mocks/upstream:cluster_mocks",
        "@envoy//test/mocks/upstream:host_mocks",
        "@envoy//test/mocks/upstream:host_set_mocks",
        "@envoy//test/mocks/upstream:thread_local_cluster_mocks",
        "@envoy//test/test_common:utility_lib",
    ],
)
