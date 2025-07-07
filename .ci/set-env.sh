#!/bin/sh
set -eu

set -a
. .ci/lib.sh
set +a

echo && echo Setting up environment

app_name='skopeo'
printf 'APP_NAME=%s\n' "$app_name" >> "$CI_ENV_FILE"
printf 'APP_VERSION=%s\n' "$(getAppVersion)" >> "$CI_ENV_FILE"

printf 'SKOPEO_VERSION=%s\n' '1.19.0' >> "$CI_ENV_FILE"
printf 'ECR_HELPER_VERSION=%s\n' '0.10.1' >> "$CI_ENV_FILE"
printf 'GCR_HELPER_VERSION=%s\n' '2.1.30' >> "$CI_ENV_FILE"
printf 'ACR_HELPER_VERSION=%s\n' '0.7.0' >> "$CI_ENV_FILE"

printf 'HARBOR_REGISTRY=%s\n' 'harbor.flakybit.net' >> "$CI_ENV_FILE"
printf 'EXTERNAL_REGISTRY_NAMESPACE=%s\n' 'flakybitnet' >> "$CI_ENV_FILE"

printf 'CRED_HELPERS_DIR=%s\n' 'dist/docker-credential-helpers' >> "$CI_ENV_FILE"

cat "$CI_ENV_FILE"

echo && echo Done
