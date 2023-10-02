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
cd united-wordpress-aws
export ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
```

3. Check if *aws s3* is available:
```shell
aws s3 ls
```

4. Copy content from the "template.txt" file or edit and save it as "envs/prod/prod.tfvars" file:

```shell 
vim envs/prod/prod.tfvars
```

```shell 
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
$ make build
```
And wait for about 20 mins


### For Deleting Resources and delete the Application:

```shell
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