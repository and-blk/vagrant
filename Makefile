SHELL = /bin/bash

.PHONY: sshkeys
sshkeys:
	mkdir ./temp;
	ssh-keygen -t rsa -f ./temp/sshkey -q -N ""
