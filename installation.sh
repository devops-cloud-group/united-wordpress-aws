#!/bin/bash

git clone --depth=1 https://github.com/tfutils/tfenv.git ~/.tfenv
echo 'export PATH=$PATH:$HOME/.tfenv/bin' >> ~/.bashrc
source ~/.bashrc 


# bash  installation.sh
# source ~/.bashrc 

# tfenv    install   1.1.1 
# tfenv    use       1.1.1 
# terraform version