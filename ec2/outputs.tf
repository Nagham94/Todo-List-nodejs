output "ec2_ip" {
  value = aws_instance.Linux-machine.public_ip
}