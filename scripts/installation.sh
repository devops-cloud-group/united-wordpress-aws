#!/bin/bash
git clone --depth=1 https://github.com/tfutils/tfenv.git ~/.tfenv
echo 'export PATH=$PATH:$HOME/.tfenv/bin' >> ~/.bashrc
source ~/.bashrc
tfenv  install  1.5.7
tfenv  use      1.5.7
terraform version