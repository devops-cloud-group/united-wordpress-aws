# Download plugins
packer {
	required_plugins {
		amazon = {
			version = ">= 0.0.1"
			source = "github.com/hashicorp/amazon"
		}
	}
}


# Prepare AMI
source "amazon-ebs" "image" {
	ami_name             = "golden-image {{timestamp}}"
	ssh_private_key_file = "/home/ec2-user/.ssh/id_rsa"
	ssh_keypair_name     = "packer"
	instance_type        = "t3.small"
	ssh_username         = "ec2-user"
	region               = "ap-southeast-1"
	// ami_users 			 = [
	// 	"128079982705"
	// ]
	// ami_regions = [
	// 	"us-east-1",
	// 	"eu-west-1",
	// 	"ap-southeast-1",
	// ] 
	source_ami = "ami-02f97949d306b597a"
	run_tags = {
		Name = "Packer instance for golden-image"
	}
}



# Build Machine
build {
	sources = [
		"source.amazon-ebs.image"
	]
	provisioner "shell" {
		inline = [
			"echo Installing Telnet",
            "sudo yum update -y",
			"sudo yum install telnet -y",
			"sudo yum install httpd -y",
			"sudo yum install php -y",
			"sudo systemctl restart httpd",
			"sudo systemctl enable httpd",
			"sudo yum install wget -y",
			"sudo wget https://wordpress.org/wordpress-4.0.32.tar.gz",
			"sudo tar -xf wordpress-4.0.32.tar.gz -C /var/www/html/",
			"sudo mv /var/www/html/wordpress/* /var/www/html/",
			"sudo chown -R apache:apache /var/www/html/",
			"sudo systemctl restart httpd"
		]
	}
	provisioner "breakpoint" {
		note = "Waiting for your verification"
	}

}