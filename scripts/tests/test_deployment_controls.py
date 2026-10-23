import copy
import importlib.util
from pathlib import Path
import unittest
from unittest.mock import patch


spec = importlib.util.spec_from_file_location(
    "controls", Path(__file__).parents[1] / "check-deployment-controls.py"
)
controls = importlib.util.module_from_spec(spec)
spec.loader.exec_module(controls)


class DeploymentControlsTest(unittest.TestCase):
    def setUp(self):
        self.settings = {
            "deployment_branch_policy": {"custom_branch_policies": True},
            "can_admins_bypass": False,
            "protection_rules": [{
                "type": "required_reviewers",
                "prevent_self_review": True,
                "reviewers": [{"type": "Team", "reviewer": {"id": 1}}],
            }],
        }
        self.branches = {"branch_policies": [{"name": "main", "type": "branch"}]}

    def verify(self, environment="prod", approved=True):
        def api(path):
            return copy.deepcopy(
                self.branches if path.endswith("deployment-branch-policies") else self.settings
            )
        with patch.object(controls, "get_api", side_effect=api):
            controls.verify(environment, approved=approved)

    def test_protected_production_is_accepted(self):
        self.verify()

    def test_missing_reviewers_are_rejected(self):
        self.settings["protection_rules"][0]["reviewers"] = []
        with self.assertRaisesRegex(RuntimeError, "reviewers"):
            self.verify()

    def test_self_approval_is_rejected(self):
        self.settings["protection_rules"][0]["prevent_self_review"] = False
        with self.assertRaisesRegex(RuntimeError, "self-review"):
            self.verify()

    def test_production_admin_bypass_is_rejected(self):
        self.settings["can_admins_bypass"] = True
        with self.assertRaisesRegex(RuntimeError, "administrator bypass"):
            self.verify()

    def test_unknown_admin_bypass_setting_is_rejected(self):
        del self.settings["can_admins_bypass"]
        with self.assertRaisesRegex(RuntimeError, "administrator bypass"):
            self.verify()

    def test_wildcard_branches_are_rejected(self):
        self.branches["branch_policies"][0]["name"] = "*"
        with self.assertRaisesRegex(RuntimeError, "main branch"):
            self.verify()

    def test_main_tag_is_not_a_branch(self):
        self.branches["branch_policies"][0]["type"] = "tag"
        with self.assertRaisesRegex(RuntimeError, "main branch"):
            self.verify()

    def test_development_can_be_automated_without_reviewers(self):
        self.settings["protection_rules"] = []
        self.verify("dev", approved=False)


if __name__ == "__main__":
    unittest.main()
