provider "aws" {
  profile = "${var.aws_profile}"
  region  = "${var.aws_region}"
}

resource "aws_instance" "ec2" {
  ami           = "${var.ami_id}"
  instance_type = "${var.instance_type}"
  count         = "${var.node_count}"
  key_name      = "${var.key_pair_name}"

  root_block_device {
    volume_type           = "standard"
    volume_size           = 50
    delete_on_termination = true
  }

  tags {
    Name = "${var.cluster_name}"
  }

  user_data = "${data.template_file.user_data.rendered}"
}

data "template_file" "user_data" {
  template = "${file("${path.module}/templates/shellscript.tpl")}"
}
