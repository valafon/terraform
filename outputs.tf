output "db_instance_address" {
  value = "${aws_db_instance.default.address}"
}

output "instance_ips" {
  value = ["${aws_instance.web.*.public_ip}"]
}
