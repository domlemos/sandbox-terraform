resource "null_resource" "reboot_instance" {

  provisioner "local-exec" {
    on_failure  = "fail"
    interpreter = ["/bin/bash", "-c"]
    command     = <<EOT
        echo -e "\x1B[31m Warning! Restarting instance having id ${aws_instance.ec2.id}.................. \x1B[0m"
        # aws ec2 reboot-instances --instance-ids ${aws_instance.ec2.id} --profile test
        # To stop instance
        aws ec2 stop-instances --instance-ids ${aws_instance.ec2.id} --profile test
        echo "***************************************Rebooted****************************************************"
     EOT
  }
#   this setting will trigger script every time,change it something needed
  triggers = {
    always_run = "${timestamp()}"
  }


}