<img src="https://github.com/devops-cloud-group/united-wordpress-aws/badge.svg?branch=main"><br>
<br>
# 3 Tier Architecture:
# Wordpress on AWS - Terraform Project 

In this project, we aim to build a three-tier wordpress application using Terraform.
<figure>
<img src="https://www.wellarchitectedlabs.com/Reliability/300_Testing_for_Resiliency_of_EC2_RDS_and_S3/Images/ThreeTierArchitecture.png">
</figure>

## Resources created:

* 1 x VPC 
* 3 x Private Subnets 
* 3 x Public Subnets 
* 1 x Internet Gateway 
* 3 x NAT Gateway 
* 1 x Public Route table 
* 1 x Private Route table 
* 1 x RDS Aurora cluster with 1 writer, 3 reader instances 
* 1 x Application Load Balancer 
* 1 x Auto Scaling Group (3 minimum 99 maximum instances) 
* 1 x security group for Web layer 
* 1 x security group for Database layer 


## Prerequisites: 

1. AWS account with configured AWS credentials (if running on an EC2, make sure to give admin privilages to the instance). 
2. Install "tfenv" using "installation.sh" file in root directory

```shell
$ bash installation.sh
```

3. Change the region and domain name in file  /envs/regions/us-west-2/prod.tfvars your own. 

```go 
public_key = "~/.ssh/id_rsa.pub"
region     = "us-west-2"
key_name   = "your_key_name"
domain     = "yourdomainname.com"
zone_id = "Z033EIIEIBCYEEX92"
```


 4. Additionally, if your VM does not have administrator priviliages, run below commands to add your AWS credentials as environment variables.

```shell 
$ export AWS_ACCESS_KEY_ID={Your AWS_ACCESS_KEY_ID} 
$ export AWS_SECRET_ACCESS_KEY={Your AWS_SECRET_ACCESS_KEY} 

$ terraform version
OUTPUT:

Terraform installed. 
Required version >= 1.1.1
```

##  Remote Backend


Provide S3 bucket and DynamoDB as Remote Backend **MANUALY**:

1.  Create S3 bucket with name of "backend/tfstate-<Account_ID>" in region "us-east-1" 

2. Create DynamoDB table name of "tfstate-team1" with LockID key using S3 url

3. Under VPC>backend.tf change "tfstate-*******" to "tfstate-<Account_ID>"

4. Initializing Terraform Terraform resources will be created using makefile.


Run makefile under same directory where makefile is located.

```go
$ make build
```

Deleting Resources To delete the Application:

```go
$ make destroy
```