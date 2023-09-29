backend:
	cd S3-Backend && terraform workspace new prod || terraform workspace select prod  && terraform init && terraform  apply  -var-file ../envs/prod/prod.tfvars --auto-approve && terraform init -backend-config=../envs/prod/config.s3.tfbackend
	bash scripts/backend-prod-setup.sh
destroy-backend:
	cd S3-Backend && terraform  destroy  -var-file ../envs/prod/prod.tfvars --auto-approve
	
build:
	cd VPC &&  terraform init -migrate-state -force-copy  &&  terraform workspace select -or-create prod  && terraform  apply   -var-file ../envs/prod/prod.tfvars --auto-approve
	cd ASG && terraform init -migrate-state -force-copy && terraform workspace select -or-create prod    &&  terraform  apply   -var-file ../envs/prod/prod.tfvars --auto-approve
	cd RDS && terraform init -migrate-state -force-copy && terraform workspace select -or-create prod    &&  terraform  apply   -var-file ../envs/prod/prod.tfvars --auto-approve

destroy:
	cd RDS && terraform workspace select prod  && terraform init &&  terraform  destroy  -var-file ../envs/prod/prod.tfvars --auto-approve
	cd ASG && terraform workspace select prod  && terraform init &&  terraform  destroy   -var-file ../envs/prod/prod.tfvars --auto-approve
	cd VPC && terraform workspace select prod  && terraform init &&  terraform  destroy   -var-file ../envs/prod/prod.tfvars --auto-approve

#TODO: check variables for mysql
mysql:
	cd RDS && terraform workspace new prod 	|| terraform workspace select prod  && terraform init &&  terraform  apply   -var-file ../prod.tfvars --auto-approve
	mysql -h $(terraform output -raw rds_hostname)) -p $(terraform output -raw rds_port)) -U $(terraform output -raw rds_username))


build-stage:
	cd VPC && terraform workspace new stage 	|| terraform workspace select stage  && terraform init &&  terraform  apply   -var-file ../envs/stage/stage.tfvars --auto-approve
	cd ASG && terraform workspace new stage 	|| terraform workspace select stage  && terraform init &&  terraform  apply   -var-file ../envs/stage/stage.tfvars --auto-approve
	cd RDS && terraform workspace new stage 	|| terraform workspace select stage  && terraform init &&  terraform  apply   -var-file ../envs/stage/stage.tfvars --auto-approve

destroy-stage:
	cd RDS && terraform workspace new stage 	|| terraform workspace select stage  && terraform init &&  terraform  destroy  -var-file ../envs/stage/stage.tfvars --auto-approve
	cd ASG && terraform workspace new stage 	|| terraform workspace select stage  && terraform init &&  terraform  destroy   -var-file ../envs/stage/stage.tfvars --auto-approve
	cd VPC && terraform workspace new stage 	|| terraform workspace select stage  && terraform init -reconfigure &&  terraform  destroy   -var-file ../envs/stage/stage.tfvars --auto-approve
