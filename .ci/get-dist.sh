#!/bin/sh
set -eu

set -a
. .ci/lib.sh
set +a

echo && echo "Update and install required system packages and dependencies"
apt-get -qq update
apt-get -qq install -y wget

mkdir -p "$CRED_HELPERS_DIR"

echo && echo "Downloading Amazon ECR Credential Helper"
wget -nv "https://amazon-ecr-credential-helper-releases.s3.us-east-2.amazonaws.com/$ECR_HELPER_VERSION/linux-amd64/docker-credential-ecr-login"
wget -nv "https://amazon-ecr-credential-helper-releases.s3.us-east-2.amazonaws.com/$ECR_HELPER_VERSION/linux-amd64/docker-credential-ecr-login.sha256"
sha256sum -c --ignore-missing docker-credential-ecr-login.sha256
mv docker-credential-ecr-login "$CRED_HELPERS_DIR"

echo && echo "Downloading GCR Credential Helper"
wget -nv "https://github.com/GoogleCloudPlatform/docker-credential-gcr/releases/download/v$GCR_HELPER_VERSION/docker-credential-gcr_linux_amd64-${GCR_HELPER_VERSION}.tar.gz"
wget -nv "https://github.com/GoogleCloudPlatform/docker-credential-gcr/releases/download/v$GCR_HELPER_VERSION/checksums.txt" -O docker-credential-gcr.sha256
sha256sum -c --ignore-missing docker-credential-gcr.sha256
tar -xzf "docker-credential-gcr_linux_amd64-${GCR_HELPER_VERSION}.tar.gz" docker-credential-gcr
mv docker-credential-gcr "$CRED_HELPERS_DIR"

echo && echo "Downloading ACR Credential Helper"
wget -nv "https://github.com/chrismellard/docker-credential-acr-env/releases/download/$ECR_HELPER_VERSION/docker-credential-acr-env_${ECR_HELPER_VERSION}_linux_amd64.tar.gz"
wget -nv "https://github.com/chrismellard/docker-credential-acr-env/releases/download/$ECR_HELPER_VERSION/checksums.txt" -O docker-credential-acr.sha256
sha256sum -c --ignore-missing docker-credential-acr.sha256
tar -xzf "docker-credential-acr-env_${ECR_HELPER_VERSION}_linux_amd64.tar.gz" docker-credential-acr-env
mv docker-credential-acr-env "$CRED_HELPERS_DIR"

echo && echo "$CRED_HELPERS_DIR:"
ls -lh "$CRED_HELPERS_DIR"

echo && echo 'Done'

