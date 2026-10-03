terraform {
  backend "s3" {
    bucket       = "yan-naing-htwe-tf-state-20260930-8472"
    key          = "dev/terraform.tfstate"
    region       = "ap-northeast-1"
    use_lockfile = true
    encrypt      = true
  }
}