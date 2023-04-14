<img src="https://github.com/devops-cloud-group/united-wordpress-aws/badge.svg?branch=main"><br>
<br>
# 3 Tier Architecture:
# Wordpress on AWS - Terraform Project 

In this project, we aim to build a three-tier wordpress application using Terraform.
<figure>
<img src="https://www.wellarchitectedlabs.com/Reliability/300_Testing_for_Resiliency_of_EC2_RDS_and_S3/Images/ThreeTierArchitecture.png">
</figure>

## Resources will be created:

* 1 x VPC 
* 2 x Private Subnets 
* 2 x Public Subnets 
* 1 x Internet Gateway 
* 2 x NAT Gateway 
* 1 x Public Route table 
* 1 x Private Route table 
* 1 x RDS Aurora cluster with 1 writer, 1 reader instances 
* 1 x Application Load Balancer 
* 1 x Auto Scaling Group (2 minimum 99 maximum instances) 
* 1 x security group for Web layer 
* 1 x security group for Database layer 


## Prerequisites: 
1. Git clone the repo
2. Go to repo directory to set up ACCOUNT_ID environment variable:
```shell
<<<<<<< HEAD
cd united-wordpress-aws
export ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
```

3. Check if *aws s3* is available:
```shell
aws s3 ls
```

4. Edit "envs/prod/prod.tfvars" file:

```shell 
vim envs/prod/prod.tfvars
```

```go 
public_key = "~/.ssh/id_rsa.pub"
region     = "your-region"       # change
key_name   = "your_key_name"     # change
domain     = "yourdomainname.com"# change
zone_id = "copy-from-route53-region-ID"# change
rds_username = "admin"            # change the username 
rds_password = "admin123"         # change the password 
tags = {
  Name = "Wordpress-VPC"
  Team = "AWS"
}
```
5. Run script to install Terraform environment and version:
=======
$ bash installation.sh
```
And also :
```shell
If we have to create new VPC in different region,  we used 'lifecycle' with condition to avoid  Route53 error:  
    - when we check the region and if it's not a basic "us-west-2" then we will not register new domains and subdomains for the project presentation purposes ONLY.
>>>>>>> 1c247be (Update README.md)

```shell
bash scripts/installation.sh
```
### Backend Setup (DynamoDB +S3)
Run Makefile:

```shell
$ make backend
```
**Script also will create  the "backend.tf" file into VPC,ASG,RDS folders**


6. Additionally, if your VM does not have administrator priviliages, run below commands to add your AWS credentials as environment variables.

```shell 
$ export AWS_ACCESS_KEY_ID={Your AWS_ACCESS_KEY_ID} 
$ export AWS_SECRET_ACCESS_KEY={Your AWS_SECRET_ACCESS_KEY} 

```

 Finnaly, run 
```shell
<<<<<<< HEAD
=======
$ touch backend.tf 
```
6. Add this block to file :
```shell
terraform {
    backend "s3" {
        bucket = "terraform-tfstate-wordpress"
        key    = "backend/terraform.tfstate"
        region = "us-west-1"
        dynamodb_table = "terraform-prod-lock"
    } 
}
```
**REPLACE ALL parameters to Your Own backend before running "terraform init"**

 **Replace parameter values when you have created your own S3 bucket and DynamoDB instance**

```go
terraform {
    backend "s3" { 
        bucket = "terraform-tfstate-wordpress"
        key    = "backend/terraform.tfstate"
        region = "us-west-1"                     
        dynamodb_table = "terraform-prod-lock"   
    } 
}

```


**Change the region and domain name in file  /envs/regions/us-west-2/prod.tfvars your own.**

```go 
public_key = "~/.ssh/id_rsa.pub"
region     = "us-west-2"
key_name   = "your_key_name"
domain     = "yourdomainname.com"
zone_id = "PUPIUUPUIIEIBCYEEX92"
```
Run makefile under same directory where makefile is located.

```go
>>>>>>> 1c247be (Update README.md)
$ make build
```
And wait for about 20 mins


### For Deleting Resources and delete the Application:

```go
$ make destroy
```
#### Test Database accessability: 

***From EC2 instance of Web in your VPC!!!***
***DB endpoints should be available from the final outputs***

```shell 
[ec2-user@ip-10-0-1-157 ~]$ mysql -h aurora-cluster-demo.cluster-ctxxweudrhd8.us-west-1.rds.amazonaws.com -u admin -p mydb
>
Enter password: ******
```
You should see:

```shell 
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MySQL connection id is 219
Server version: 8.0.23 Source distribution

Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.

```