mock_provider "aws" {
  mock_data "aws_availability_zones" {
    defaults = { names = ["ap-northeast-1a", "ap-northeast-1c"] }
  }
  mock_data "aws_ssm_parameter" {
    defaults = { value = "ami-0123456789abcdef0" }
  }
}
variables {
  certificate_arn = "arn:aws:acm:ap-northeast-1:123456789012:certificate/test"
  alarm_topic_arn = "arn:aws:sns:ap-northeast-1:123456789012:test-alarms"
  db_username     = "testuser"
  db_password     = "test-password-only"
}
run "staging_profile" {
  command = plan
  assert {
    condition     = output.https_enabled && output.application_instance_type == "t3.small"
    error_message = "The environment must use HTTPS and the selected compute profile."
  }
  assert {
    condition     = output.database_multi_az == false && module.platform.rds_monitoring_interval == 60
    error_message = "The database availability and enhanced-monitoring profile must match the environment."
  }
  assert {
    condition     = output.minimum_instances == 1 && output.maximum_instances == 2
    error_message = "The Auto Scaling group must use the environment capacity limits."
  }
  assert {
    condition     = output.monitoring_level == "enhanced" && length(output.alarm_names) == 4
    error_message = "The expected monitoring tier and alarms must be enabled."
  }
}
run "staging_can_test_multi_az" {
  command = plan
  variables { staging_multi_az = true }
  assert {
    condition     = output.database_multi_az
    error_message = "Staging must support Multi-AZ testing when requested."
  }
}
