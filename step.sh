#!/usr/bin/env -S bash -ex

set -o pipefail

XCRESULT_BUNDLE_TEMP="$(mktemp -d)"
XCRESULT_BUNDLE_NAME="Tests.xcresult"
XCRESULT_BUNDLE_PATH="${XCRESULT_BUNDLE_TEMP}/${XCRESULT_BUNDLE_NAME}"

envman add --key XCRESULT_BUNDLE_PATH --value "${XCRESULT_BUNDLE_PATH}"

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

(
  cd "${XCRESULT_BUNDLE_TEMP}"
  exec zip -r "${BITRISE_DEPLOY_DIR}/xcresult.zip" "${XCRESULT_BUNDLE_NAME}"
)
