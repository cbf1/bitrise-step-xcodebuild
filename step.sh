#!/usr/bin/env bash -ex

set -o pipefail

XCRESULT_BUNDLE_PATH="$(mktemp -d)/Test.xcresult"

env NSUnbufferedIO=YES \
xcodebuild \
-workspace "${xcodebuild_workspace}" \
-scheme "${xcodebuild_scheme}" \
-sdk "${xcodebuild_sdk}" \
-destination "${xcodebuild_destination}" \
-resultBundlePath "${XCRESULT_BUNDLE_PATH}" \
"${xcodebuild_actions}" \
| tee "${raw_xcodebuild_output}" \
| "${xcodebuild_output_formatter}"

envman add --key XCRESULT_BUNDLE_PATH --value "${XCRESULT_BUNDLE_PATH}"
