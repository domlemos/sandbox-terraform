resource "null_resource" "run-ansible" {   

  provisioner "remote-exec" {
    connection {
        host        = coalesce(aws_instance.dev.public_ip, aws_instance.dev.private_ip)
        agent       = true
        type        = "ssh"
        user        = "ubuntu"
        private_key = file(pathexpand("terraform-aws"))
    }

    inline = ["echo 'connected!'"]
  }

  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook ./ansible/provisioning.yml -u ubuntu -i ./ansible/hosts --private-key terraform-aws"
  }
}
