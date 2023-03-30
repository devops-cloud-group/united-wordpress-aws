build:
	packer init .
	packer validate .
	packer build image.pkr.hcl