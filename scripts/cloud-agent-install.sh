#!/usr/bin/env bash
# Idempotent Cloud Agent bootstrap: install Terraform for this lab.
set -euo pipefail

TF_VERSION="${TF_VERSION:-1.16.3}"
ARCH="$(uname -m)"
case "${ARCH}" in
  x86_64|amd64) TF_ARCH="amd64" ;;
  aarch64|arm64) TF_ARCH="arm64" ;;
  *)
    echo "Unsupported architecture: ${ARCH}" >&2
    exit 1
    ;;
esac

if command -v terraform >/dev/null 2>&1; then
  current="$(terraform version -json 2>/dev/null | python3 -c 'import json,sys; print(json.load(sys.stdin)["terraform_version"])' 2>/dev/null || true)"
  if [[ "${current}" == "${TF_VERSION}" ]]; then
    echo "Terraform ${TF_VERSION} already installed."
    terraform version
    exit 0
  fi
fi

tmp="$(mktemp -d)"
trap 'rm -rf "${tmp}"' EXIT

zip_name="terraform_${TF_VERSION}_linux_${TF_ARCH}.zip"
base_url="https://releases.hashicorp.com/terraform/${TF_VERSION}"

curl -fsSL "${base_url}/${zip_name}" -o "${tmp}/${zip_name}"
curl -fsSL "${base_url}/terraform_${TF_VERSION}_SHA256SUMS" -o "${tmp}/SHA256SUMS"

(
  cd "${tmp}"
  sha256sum --check --ignore-missing SHA256SUMS
  unzip -o "${zip_name}"
)

sudo install -m 0755 "${tmp}/terraform" /usr/local/bin/terraform
terraform version
