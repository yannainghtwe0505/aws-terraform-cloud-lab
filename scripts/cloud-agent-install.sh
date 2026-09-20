#!/usr/bin/env bash
# Idempotent Cloud Agent bootstrap: Terraform + AWS CLI for this lab.
set -euo pipefail

TF_VERSION="${TF_VERSION:-1.16.3}"
ARCH="$(uname -m)"
case "${ARCH}" in
  x86_64|amd64)
    TF_ARCH="amd64"
    AWS_CLI_ARCH="x86_64"
    ;;
  aarch64|arm64)
    TF_ARCH="arm64"
    AWS_CLI_ARCH="aarch64"
    ;;
  *)
    echo "Unsupported architecture: ${ARCH}" >&2
    exit 1
    ;;
esac

install_terraform() {
  if command -v terraform >/dev/null 2>&1; then
    current="$(terraform version -json 2>/dev/null | python3 -c 'import json,sys; print(json.load(sys.stdin)["terraform_version"])' 2>/dev/null || true)"
    if [[ "${current}" == "${TF_VERSION}" ]]; then
      echo "Terraform ${TF_VERSION} already installed."
      terraform version
      return 0
    fi
  fi

  tmp="$(mktemp -d)"
  # shellcheck disable=SC2064
  trap "rm -rf '${tmp}'" RETURN

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
}

install_aws_cli() {
  # aws login (console credentials) requires AWS CLI >= 2.32.0
  if command -v aws >/dev/null 2>&1; then
    echo "AWS CLI already installed."
    aws --version
    return 0
  fi

  tmp="$(mktemp -d)"
  # shellcheck disable=SC2064
  trap "rm -rf '${tmp}'" RETURN

  zip_name="awscliv2.zip"
  curl -fsSL "https://awscli.amazonaws.com/awscli-exe-linux-${AWS_CLI_ARCH}.zip" -o "${tmp}/${zip_name}"
  unzip -q -o "${tmp}/${zip_name}" -d "${tmp}"
  sudo "${tmp}/aws/install" --update
  aws --version
}

install_terraform
install_aws_cli

# Help aws login / aws sso login open the Cloud desktop browser.
if [[ -z "${BROWSER:-}" ]] && command -v google-chrome >/dev/null 2>&1; then
  echo "Tip: export BROWSER=google-chrome before aws login if the browser does not open."
fi
