# 3 Tier Architeture:
# Wordpress on AWS - Terraform Project 

In this project, we aim to build a three-tier wordpress application using Terraform.

## Resources created:

* 1 x VPC 
* 3 x Private Subnets 
* 3 x Public Subnets 
* 1 x Internet Gateway 
* 1 x NAT Gateway 
* 1 x Public Route table 
* 1 x Private Route table 
* 1 x RDS Aurora cluster with 1 writer, 3 reader instances 
* 1 x Application Load Balancer 
* 1 x Auto Scaling Group (3 minimum 99 maximum instances) 
* 1 x security group for Web layer 
* 1 x security group for Database layer 
* 1 x security group for EFS Route53

## Prerequisites: 

1. AWS account with configured AWS credentials (if running on an EC2, make sure to give admin privilages to the instance). 
2. Add below Terraform environment variables on the command line or add them in ~/.bashrc . 
3. Change the region and domain name to your own. 

```shell 
$ export TF_VAR_region=us-east-1 

$ export TF_VAR_domain_name=domain.com
```


 4. Additionally, if your VM does not have administrator priviliages, run below commands to add your AWS credentials as environment variables.

```shell 
$ export AWS_ACCESS_KEY_ID={Your AWS_ACCESS_KEY_ID} 
$ export AWS_SECRET_ACCESS_KEY={Your AWS_SECRET_ACCESS_KEY} Terraform installed. Required version >= 1.1.1
```

During the init process *MANUALLY*:

1.  Create S3 bucket with name of "tfstate-<Account_ID>" in region "us-east-1" as Remote Backend

2. Create DynamoDB table name of "tfstate-team1" with LockID key using S3 url

3. Under VPC>backend.tf change "tfstate-*******" to "tfstate-<Account_ID>"

4. Initializing Terraform Terraform resources will be created using makefile.


Run makefile under same directory where makefile is located.

```shell 
make build
```

Deleting Resources To delete the Application:

```shell
make destroy
```