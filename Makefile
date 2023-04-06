build:
	cd VPC && terraform workspace new prod 	|| terraform workspace select prod  && terraform init &&  terraform  apply   -var-file envs/regions/us-west-2/prod.tfvars --auto-approve
	cd RDS && terraform workspace new prod 	|| terraform workspace select prod  && terraform init &&  terraform  apply   -var-file envs/regions/us-west-2/prod.tfvars --auto-approve
	cd ASG && terraform workspace new prod 	|| terraform workspace select prod  && terraform init &&  terraform  apply   -var-file envs/regions/us-west-2/prod.tfvars --auto-approve

destroy:
	
	cd ASG && terraform workspace new prod 	|| terraform workspace select prod  && terraform init &&  terraform  destroy   -var-file envs/regions/us-west-2/prod.tfvars --auto-approve
	cd RDS && terraform workspace new prod 	|| terraform workspace select prod  && terraform init &&  terraform  destroy  -var-file envs/regions/us-west-2/prod.tfvars --auto-approve
	cd VPC && terraform workspace new prod 	|| terraform workspace select prod  && terraform init &&  terraform  destroy   -var-file envs/regions/us-west-2/prod.tfvars --auto-approve

mysql:
	cd RDS && terraform workspace new prod 	|| terraform workspace select prod  && terraform init &&  terraform  apply   -var-file envs/regions/us-west-2/prod.tfvars --auto-approve
	mysql -h $(echo $(terraform output -raw rds_hostname)) -p $(echo $(terraform output -raw rds_port)) -U $(echo $(terraform output -raw rds_username))