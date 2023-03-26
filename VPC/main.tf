resource "aws_key_pair" "state-vpc" {
    key_name   = "state-vpc-key"
    public_key = file("~/.ssh/id_rsa.pub")
}