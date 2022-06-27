terraform {
  backend "s3" {
    bucket = "tfstatearun"
    key    = "terraform/hadoop/terraform.tfstate"

    # role_arn = "arn:aws:iam::507575835992:user/arunsandu"
    profile = "arunsandu"
    region  = "us-east-2"
  }
}
