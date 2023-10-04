backend:
	bash scripts/backend-prod-setup.sh
	cd S3-Backend && terraform init  && terraform workspace new prod || terraform workspace select prod   && terraform  apply  -var-file ../envs/prod/prod.tfvars --auto-approve

destroy-backend:
	cd S3-Backend && terraform  destroy  -var-file ../envs/prod/prod.tfvars --auto-approve
	
build:
	cd VPC &&  terraform init -migrate-state  &&  terraform workspace select -or-create prod  && terraform  apply   -var-file ../envs/prod/prod.tfvars --auto-approve
	cd ASG && terraform init -migrate-state  && terraform workspace select -or-create prod    &&  terraform  apply   -var-file ../envs/prod/prod.tfvars --auto-approve
	cd RDS && terraform init -migrate-state  && terraform workspace select -or-create prod    &&  terraform  apply   -var-file ../envs/prod/prod.tfvars --auto-approve
	
destroy:
	cd RDS && terraform workspace select prod  &&  terraform  destroy  -var-file ../envs/prod/prod.tfvars --auto-approve
	cd ASG && terraform workspace select prod  &&  terraform  destroy   -var-file ../envs/prod/prod.tfvars --auto-approve
	cd VPC && terraform workspace select prod  &&  terraform  destroy   -var-file ../envs/prod/prod.tfvars --auto-approve

build-stage:
	cd VPC && terraform workspace new stage || terraform workspace select stage  && terraform init &&  terraform  apply   -var-file ../envs/stage/stage.tfvars --auto-approve
	cd ASG && terraform workspace new stage || terraform workspace select stage  && terraform init &&  terraform  apply   -var-file ../envs/stage/stage.tfvars --auto-approve
	cd RDS && terraform workspace new stage || terraform workspace select stage  && terraform init &&  terraform  apply   -var-file ../envs/stage/stage.tfvars --auto-approve
	
destroy-stage:
	cd RDS && terraform workspace new stage 	|| terraform workspace select stage  && terraform init &&  terraform  destroy  -var-file ../envs/stage/stage.tfvars --auto-approve
	cd ASG && terraform workspace new stage 	|| terraform workspace select stage  && terraform init &&  terraform  destroy   -var-file ../envs/stage/stage.tfvars --auto-approve
	cd VPC && terraform workspace new stage 	|| terraform workspace select stage  && terraform init -reconfigure &&  terraform  destroy   -var-file ../envs/stage/stage.tfvars --auto-approve
	