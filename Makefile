build:
	ssh-keygen -f terraform-aws -t rsa -N ""
	aws ec2 import-key-pair --key-name "terraform-aws" --public-key-material file://terraform-aws.pub
	./terraform init
	./terraform plan
	./terraform apply -auto-approve
