build-virginia:
	terraform workspace new virginia 		|| terraform workspace select virginia  && terraform init &&   			terraform  apply   -var-file envs/regions/us-east-1/virginia.tfvars --auto-approve

destroy-virginia:
	terraform workspace new virginia		|| terraform workspace select virginia  && terraform init &&    		terraform  destroy   -var-file envs/regions/us-east-1/virginia.tfvars --auto-approve
