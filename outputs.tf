output "Linux-machine_public_ip" {
  description = "Public IP of the Linux machine"
  value = module.instance.ec2_ip
}