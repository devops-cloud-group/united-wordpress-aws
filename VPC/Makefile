
build-cali:
	terraform workspace new cali 	|| terraform workspace select cali  && terraform init &&  terraform  apply   -var-file envs/regions/us-west-2/prod.tfvars --auto-approve

destroy-cali:
	terraform workspace new cali 	|| terraform workspace select cali  && terraform init &&  terraform  destroy   -var-file  envs/regions/us-west-2/prod.tfvars --auto-approve

build-all:
	make build-ohio && make build-ireland && make build-singapore

destroy-all:
	make destroy-ohio && make destroy-ireland && make destroy-singapore