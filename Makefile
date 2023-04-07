build:
	cd VPC && terraform workspace new prod 	|| terraform workspace select prod  && terraform init -reconfigure &&  terraform  apply   -var-file ../prod.tfvars --auto-approve
	cd RDS && terraform workspace new prod 	|| terraform workspace select prod  && terraform init -reconfigure &&  terraform  apply   -var-file ../prod.tfvars --auto-approve
	cd ASG && terraform workspace new prod 	|| terraform workspace select prod  && terraform init -reconfigure  &&  terraform  apply   -var-file ../prod.tfvars --auto-approve

destroy:
	
	cd ASG && terraform workspace new prod 	|| terraform workspace select prod  && terraform init &&  terraform  destroy   -var-file ../prod.tfvars --auto-approve
	cd RDS && terraform workspace new prod 	|| terraform workspace select prod  && terraform init &&  terraform  destroy  -var-file ../prod.tfvars --auto-approve
	cd VPC && terraform workspace new prod 	|| terraform workspace select prod  && terraform init &&  terraform  destroy   -var-file ../prod.tfvars --auto-approve

#TODO: check variables for mysql
mysql:
	cd RDS && terraform workspace new prod 	|| terraform workspace select prod  && terraform init &&  terraform  apply   -var-file ../prod.tfvars --auto-approve
	mysql -h $(echo $(terraform output -raw rds_hostname)) -p $(echo $(terraform output -raw rds_port)) -U $(echo $(terraform output -raw rds_username))


build-stage:
	cd VPC && terraform workspace new stage 	|| terraform workspace select stage  && terraform init &&  terraform  apply   -var-file ../stage.tfvars --auto-approve
	cd RDS && terraform workspace new stage 	|| terraform workspace select stage  && terraform init &&  terraform  apply   -var-file ../stage.tfvars --auto-approve
	cd ASG && terraform workspace new stage 	|| terraform workspace select stage  && terraform init &&  terraform  apply   -var-file ../stage.tfvars --auto-approve

destroy-stage:
	
	cd ASG && terraform workspace new stage 	|| terraform workspace select stage  && terraform init &&  terraform  destroy   -var-file ../stage.tfvars --auto-approve
	cd RDS && terraform workspace new stage 	|| terraform workspace select stage  && terraform init &&  terraform  destroy  -var-file ../stage.tfvars --auto-approve
	cd VPC && terraform workspace new stage 	|| terraform workspace select stage  && terraform init &&  terraform  destroy   -var-file ../stage.tfvars --auto-approve
