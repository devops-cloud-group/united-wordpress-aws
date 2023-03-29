build-ohio:
	terraform workspace new ohio 		|| terraform workspace select ohio  && terraform init &&   			terraform  apply   -var-file envs/regions/us-east-2/ohio.tfvars --auto-approve

destroy-ohio:
	terraform workspace new ohio 		|| terraform workspace select ohio  && terraform init &&    		terraform  destroy   -var-file envs/regions/us-east-2/ohio.tfvars --auto-approve

build-ireland:
	terraform workspace new ireland 	|| terraform workspace select ireland  && terraform init &&    		terraform  apply   -var-file envs/regions/eu-west-1/ireland.tfvars --auto-approve

destroy-ireland:
	terraform workspace new ireland 	|| terraform workspace select ireland  && terraform init &&  		terraform  destroy   -var-file envs/regions/eu-west-1/ireland.tfvars --auto-approve

build-singapore:
	terraform workspace new singapore 	|| terraform workspace select singapore  && terraform init &&    	terraform  apply   -var-file envs/regions/ap-southeast-1/singapore.tfvars --auto-approve

destroy-singapore:
	terraform workspace new singapore 	|| terraform workspace select singapore  && terraform init &&  		terraform  destroy   -var-file envs/regions/ap-southeast-1/singapore.tfvars --auto-approve



build-all:
	make build-ohio && make build-ireland && make build-singapore


destroy-all:
	make destroy-ohio && make destroy-ireland && make destroy-singapore