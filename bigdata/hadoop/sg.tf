resource "aws_security_group" "hadoop_sg" {
  name        = "hadoop-sg"
  description = "Hadoop Security Group"
  vpc_id      = "${var.vpc_id}"

  tags {
    Name   = "${var.cluster_name}-cloudera"
    SGType = "Cloudera"
  }
}

resource "aws_security_group_rule" "ingress_ssh" {
  description       = "ssh port"
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.hadoop_sg.id}"
}

resource "aws_security_group_rule" "ingress_hadoop_namenode" {
  description       = "hadoop port"
  type              = "ingress"
  from_port         = 8020
  to_port           = 8020
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.hadoop_sg.id}"
}

resource "aws_security_group_rule" "egress_hadoop" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.hadoop_sg.id}"
}
