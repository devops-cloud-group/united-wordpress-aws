<img src="https://github.com/devops-cloud-group/united-wordpress-aws/badge.svg?branch=main"><br>
<br>
# 3 Tier Architecture:
# Wordpress on AWS - Terraform for multiple teams Project 

<div style="background-color: blue; color: white; padding: 10px; border-radius: 5px;">

In this project, we aimed to build a three-tier wordpress application using Terraform in a real-world environment where devops team distributed around the world and each block is provided by independent contributors or groups. 
 To make it possible we use "remote" backend for Terraform on S3 bucket (versioning enabled) and DynamoDB to keep state locked for only a transaction in a time. This approach allowes working as a team  on the same terraform.tfstate file.

 Also in production environment we have implemented a separate backend files for each team using different keys(path) to the terraform.tfstate files

</div>
<figure>
<img src="https://www.wellarchitectedlabs.com/Reliability/300_Testing_for_Resiliency_of_EC2_RDS_and_S3/Images/ThreeTierArchitecture.png">
</figure>

## Resources will be created:

### Backend-S3-DynamoDB
* 1 x S3 bucket (prod env)
* 1 x DynamoDB table

### Infrastructure
* 1 x VPC 
* 2 x Private Subnets 
* 2 x Public Subnets 
* 1 x Public Route table 
* 1 x Private Route table
* 1 x Internet Gateway 
* 2 x NAT Gateway  

### Frontend layer

* 1 x Application Load Balancer 
* 1 x Auto Scaling Group (2 minimum 99 maximum instances-horizontally scalable) 
* 1 x security group for Web layer 
* 2 x EC2 instances (minimum) (WordPress)


### Database layer

* 1 x RDS Aurora cluster with 1 writer, 1 reader instances (horizontally scalable)
* 1 x security group for Database layer  


## Prerequisites: 
1. Git clone the repo
2. Go to repo directory:
```shell
cd united-wordpress-aws
```

3. Check if  *aws s3*  is available:
```shell
aws s3 ls
```

4. Copy content from the "template.txt" file or edit and save it as "envs/prod/prod.tfvars" file:

```shell 
vim envs/prod/prod.tfvars
```

```shell 
public_key = "~/.ssh/id_rsa.pub"
region     = "your-region"              # change if needed
key_name   = "your_key_name"            # change
domain     = "yourdomainname.com"       # change
zone_id = "copy-from-route53-region-ID" # change
rds_username = "admin"                  # change the username 
rds_password = "admin123"               # change the password 
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


6. Optionally, if your VM does not have administrator priviliages, run below commands to add your AWS credentials as environment variables.

```shell 
$ export AWS_ACCESS_KEY_ID={Your AWS_ACCESS_KEY_ID} 
$ export AWS_SECRET_ACCESS_KEY={Your AWS_SECRET_ACCESS_KEY} 

```

7. Finaly, run 
```shell
$ make build
```
And wait for about 20 mins


### For Deleting Resources and delete the Application:

```shell
$ make destroy

```
#### TROUBLESHOOTING: 

In case of error when deleteing S3 bucket use AWS console and manually empty and delete the bucket
```shell

│ Error: deleting Amazon S3 (Simple Storage) Bucket (terraform-tfstate-prod-1999999999999): BucketNotEmpty: The bucket you tried to delete is not empty. You must delete all versions in the bucket.
│       status code: 409, request id: HAMSEY42N6MG45QR, host id: h8kkpMo03yqa5U+esfQJZwgeaenEg63dqUexPPYV4b4j63JNfQjiJO8WlwyifBF5qK5OeE7ZXlU=
│ 
```

## Test Database accessability: 

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
