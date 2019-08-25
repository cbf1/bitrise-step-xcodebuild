#!/usr/bin/env bash -ex

set -o pipefail

RESULT_BUNDLE_PATH="$(mktemp -d)/Test.xcresult"

env NSUnbufferedIO=YES \
xcodebuild \
-workspace "${xc_option_workspace}" \
-scheme "${xc_option_scheme}" \
-sdk "${xc_option_sdk}" \
-destination "${xc_option_destination}" \
-resultBundlePath "${RESULT_BUNDLE_PATH}" \
"${xcodebuild_actions}" \
| tee "${raw_xcodebuild_output}" \
| "${xcodebuild_output_formatter}"

cp -a "${RESULT_BUNDLE_PATH}" "${BITRISE_TEST_DEPLOY_DIR}/${BITRISE_SCHEME}/"
