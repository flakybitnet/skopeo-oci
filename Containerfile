ARG SKOPEO_VERSION
FROM quay.io/containers/skopeo:$SKOPEO_VERSION

ARG CRED_HELPERS_DIR
COPY --chown=root:root --chmod=755 $CRED_HELPERS_DIR /usr/bin
