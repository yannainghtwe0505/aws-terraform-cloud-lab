"""Fail closed until GitHub environment protections are configured externally."""

import json
import os
import sys
from urllib.error import HTTPError
from urllib.parse import quote
from urllib.request import Request, urlopen


def get_api(path):
    request = Request(
        f"https://api.github.com/repos/{os.environ['GITHUB_REPOSITORY']}/{path}",
        headers={
            "Authorization": f"Bearer {os.environ['GH_TOKEN']}",
            "Accept": "application/vnd.github+json",
            "X-GitHub-Api-Version": "2022-11-28",
        },
    )
    try:
        with urlopen(request, timeout=30) as response:
            return json.load(response)
    except HTTPError as error:
        raise RuntimeError(
            f"Cannot verify {path} (HTTP {error.code}); configure the environment "
            "and provide a token with permission to read its protection settings."
        ) from error


def verify(environment, approved=False):
    path = f"environments/{quote(environment, safe='')}"
    settings = get_api(path)
    branches = settings.get("deployment_branch_policy") or {}
    if not branches.get("custom_branch_policies"):
        raise RuntimeError(f"{environment}: select an explicit deployment branch policy for main.")
    policies = get_api(f"{path}/deployment-branch-policies")["branch_policies"]
    if len(policies) != 1 or policies[0].get("name") != "main" or policies[0].get("type") != "branch":
        raise RuntimeError(f"{environment}: allow only the main branch; tags and wildcards are not permitted.")
    if approved:
        reviewer_rules = [
            rule for rule in settings.get("protection_rules", [])
            if rule.get("type") == "required_reviewers"
        ]
        if not reviewer_rules or not reviewer_rules[0].get("reviewers"):
            raise RuntimeError(f"{environment}: required deployment reviewers are missing.")
        if not reviewer_rules[0].get("prevent_self_review"):
            raise RuntimeError(f"{environment}: prevent self-review must be enabled.")
        if environment == "prod" and settings.get("can_admins_bypass", True):
            raise RuntimeError("prod: disable administrator bypass of environment protection rules.")


def main():
    environment = sys.argv[1]
    if environment not in {"dev", "staging", "prod"}:
        raise RuntimeError("Choose dev, staging, or prod.")
    if os.environ.get("GITHUB_REF") != "refs/heads/main":
        raise RuntimeError("Deployments must run from main.")
    verify(f"{environment}-plan")
    verify(environment, approved=environment != "dev")
    print(f"Verified branch and approval protections for {environment}.")


if __name__ == "__main__":
    main()
